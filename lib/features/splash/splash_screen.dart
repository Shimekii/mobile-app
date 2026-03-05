import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/app_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Запускаем инициализацию приложения
    Future.microtask(() =>
        context.read<AppViewModel>().initializeApp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // индикатор загрузки
      ),
    );
  }
}