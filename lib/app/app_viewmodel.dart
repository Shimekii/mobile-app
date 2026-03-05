import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isFirstLaunch = true; // проверка, был ли первый запуск

  bool get isLoading => _isLoading;
  bool get isFirstLaunch => _isFirstLaunch;

  Future<void> initializeApp() async {
    // Имитируем загрузку
    await Future.delayed(Duration(seconds: 2));

    // Здесь обычно читаем SharedPreferences или local storage
    // чтобы понять, нужно ли показывать onboarding
    _isFirstLaunch = true; // пример, можно поставить false если уже запускали

    _isLoading = false;
    notifyListeners();
  }

  void completeOnboarding() { 
    _isFirstLaunch = false;
    notifyListeners();
    // Здесь можно сохранить флаг в SharedPreferences
  }
}