import 'package:air_check/features/select_city/select_city_view.dart';
import 'package:air_check/features/welcome/home_screen.dart';
import 'package:air_check/features/error/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_root.dart';
import 'app/app_viewmodel.dart';
import 'features/welcome/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Demo',
      routes: {
        "/welcome": (context) => WelcomeScreen(),
        "/home": (context) => HomeScreen(),
        "/noInternet": (context) => NoInternetScreen(),
        "/addMainCity": (context) => SelectCityView()
      },
      home: AppRoot(),
    );
  }
}
