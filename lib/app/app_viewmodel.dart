import 'package:air_check/services/connectivity_service.dart';
import 'package:air_check/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppViewModel extends ChangeNotifier {
  final LocationService locationService = LocationService();
  final ConnectivityService connectivityService = ConnectivityService();
  double? latitude;
  double? longitude;
  bool _isLoading = true;
  bool _isFirstLaunch = true; // проверка, был ли первый запуск
  bool hasInternet = false;

  bool get isLoading => _isLoading;
  bool get isFirstLaunch => _isFirstLaunch;

  Future<void> initializeApp() async {
    // Имитируем загрузку
    await Future.delayed(Duration(seconds: 2));
    hasInternet = await connectivityService.hasInternet();
    // Здесь обычно читаем SharedPreferences или local storage
    // чтобы понять, нужно ли показывать onboarding
    _isFirstLaunch = true; // пример, можно поставить false если уже запускали

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> requestLocation() async {
    bool granted = await locationService.requestPermission();

    if (granted){
      Position pos = await locationService.getCoordinates();
      latitude = pos.latitude;
      longitude = pos.longitude;
    }
    notifyListeners();
    return granted;
  }

  void completeOnboarding() { 
    _isFirstLaunch = false;
    notifyListeners();
    // Здесь можно сохранить флаг в SharedPreferences
  }
}