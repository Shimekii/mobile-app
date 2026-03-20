import 'package:air_check/core/models/city.dart';
import 'package:air_check/core/models/coordinates.dart';
import 'package:air_check/core/repositories/air_quality_data.dart';
import 'package:air_check/core/repositories/air_repository.dart';
import 'package:air_check/core/repositories/city_repository.dart';
import 'package:air_check/core/repositories/location_repository.dart';
import 'package:air_check/core/services/connectivity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppViewModel extends ChangeNotifier {
  final LocationRepository locationRepository = LocationRepository();
  final ConnectivityService connectivityService = ConnectivityService();
  final AirRepository airRepository = AirRepository();
  final CityRepository cityRepository = CityRepository();

  bool _isLoading = true;
  bool _isFirstLaunch = true; // проверка, был ли первый запуск
  bool hasInternet = false;
  bool mainCitySelected = false;
  bool get isLoading => _isLoading;
  bool get isFirstLaunch => _isFirstLaunch;

  City? mainCity;

  List<City> trackedCities = []; // список отслеживаемых городов

  Future<void> initializeApp() async {
    // Имитируем загрузку
    await Future.delayed(Duration(seconds: 2));
    hasInternet = await connectivityService.hasInternet();
    final prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    final name = prefs.getString("mainCity_name");
    final lat = prefs.getDouble("mainCity_lat");
    final lon = prefs.getDouble("mainCity_lon");

    if (name != null && lat != null && lon != null){
      final coords = Coordinates(lat, lon);
      final aqd = await airRepository.loadAirQualityByCoord(coords);
      mainCity = City(name, aqd, coords);
      mainCitySelected = true;
    }

    await loadTrackedCities(); // подгружаем отслеживаемые города, добавленные

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> requestLocation() async {
    bool granted = await locationRepository.requestLocationPermission();

    if (granted){
      Position pos = await locationRepository.getCurrentPosition();
      String? name = await cityRepository.fetchCityNameByCoordinates(pos.latitude, pos.longitude);
      Coordinates coords = Coordinates(pos.latitude, pos.longitude);
      AirQualityData aqd = await airRepository.loadAirQualityByCoord(coords);
      mainCity = City(name!, aqd, coords);

      mainCitySelected = true;
    }
    await saveMainCity();
    notifyListeners();
    return granted;
  }

  Future<void> completeOnboarding() async { 
    _isFirstLaunch = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    // Здесь можно сохранить флаг в SharedPreferences
  }

  void setMainCity(City city){
    mainCity = city;
    notifyListeners();
  }

  // булева функция добавления города в список для отслеживания с запросом его реального показателя качества воздуха
  Future<bool> addTrackedCityByName(String cityName) async {
    final coords = await cityRepository.fetchCoordinates(cityName);

    if (coords == null) return false;

    final exists = trackedCities.any((c) => c.name == cityName);
    if (exists) return false;

    final aqd = await airRepository.loadAirQualityByCoord(coords);

    final newCity = City(cityName, aqd, coords);

    trackedCities.add(newCity);

    await saveTrackedCities();
    notifyListeners();

    return true;
  }

  // сохранение локально данных об отслеживаемых городах
  Future<void> saveTrackedCities() async {
    final prefs = await SharedPreferences.getInstance();

    final names = trackedCities.map((c) => c.name).toList();
    final lats = trackedCities.map((c) => c.coordinates.lat.toString()).toList();
    final lons = trackedCities.map((c) => c.coordinates.lon.toString()).toList();

    await prefs.setStringList("tracked_names", names);
    await prefs.setStringList("tracked_lats", lats);
    await prefs.setStringList("tracked_lons", lons);
  }

  // загрузка из локального хранилища отслеживаемых городов
  Future<void> loadTrackedCities() async {
    final prefs = await SharedPreferences.getInstance();

    final names = prefs.getStringList("tracked_names") ?? [];
    final lats = prefs.getStringList("tracked_lats") ?? [];
    final lons = prefs.getStringList("tracked_lons") ?? [];

    trackedCities.clear();

    for (int i = 0; i < names.length; i++) {
      final name = names[i];
      final lat = double.parse(lats[i]);
      final lon = double.parse(lons[i]);

      final coords = Coordinates(lat, lon);
      final aqd = await airRepository.loadAirQualityByCoord(coords);

      trackedCities.add(City(name, aqd, coords));
    }
  }

    Future<void> getAqi() async {
    if (mainCity == null) return;


    AirQualityData aqd =
        await airRepository.loadAirQualityByCoord(mainCity!.coordinates);

    if (mainCity != null) {
      mainCity!.updateCurrent(aqd);
    }

    notifyListeners();
  }

  Future<void> saveMainCity() async {
    if (mainCity == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("mainCity_name", mainCity!.name);
    await prefs.setDouble("mainCity_lat", mainCity!.coordinates.lat);
    await prefs.setDouble("mainCity_lon", mainCity!.coordinates.lon);
  }
}