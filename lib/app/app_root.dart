import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_viewmodel.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/view/home_screen.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return SplashScreen();
        } else if (vm.isFirstLaunch) {
          return OnboardingScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}