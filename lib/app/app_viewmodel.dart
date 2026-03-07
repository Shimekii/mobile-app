import 'package:air_check/main.dart';
import 'package:air_check/models/city.dart';
import 'package:air_check/models/coordinates.dart';
import 'package:air_check/repositories/air_quality_data.dart';
import 'package:air_check/repositories/air_repository.dart';
import 'package:air_check/services/city_service.dart';
import 'package:air_check/services/connectivity_service.dart';
import 'package:air_check/services/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppViewModel extends ChangeNotifier {
  final LocationService locationService = LocationService();
  final ConnectivityService connectivityService = ConnectivityService();
  final AirRepository airRepository = AirRepository();
  final CityService cityService = CityService();

  bool _isLoading = true;
  bool _isFirstLaunch = true; // проверка, был ли первый запуск
  bool hasInternet = false;
  bool mainCitySelected = false;
  bool get isLoading => _isLoading;
  bool get isFirstLaunch => _isFirstLaunch;

  City? mainCity;

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
  

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> requestLocation() async {
    bool granted = await locationService.requestPermission();

    if (granted){
      Position pos = await locationService.getCoordinates();
      String? name = await cityService.getCityNameByCoord(pos.latitude, pos.longitude);
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

  Future<void> isSelect() async{
    mainCitySelected = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("mainCitySelected", true);
  }

  void setMainCity(City city){
    mainCity = city;
    notifyListeners();
  }

  Future<void> getCurrentAqi() async {
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