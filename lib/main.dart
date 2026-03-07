import 'package:air_check/features/view/select_city_viewmodel.dart';
import 'package:air_check/features/view/home_screen.dart';
import 'package:air_check/features/view/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_root.dart';
import 'app/app_viewmodel.dart';
import 'features/view/welcome_screen.dart';

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