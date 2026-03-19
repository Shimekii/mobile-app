import 'package:air_check/features/error/no_internet_screen.dart';
import 'package:air_check/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_viewmodel.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/welcome/home_screen.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return SplashScreen();
        } else if (vm.isFirstLaunch) {
          return OnboardingScreen();
        } else if (!vm.hasInternet) {
          return NoInternetScreen();
        } else if (vm.mainCitySelected){
          return HomeScreen();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}