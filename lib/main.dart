import 'package:air_check/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
        ),
      home: const HomePage(),
    );
  }
}
