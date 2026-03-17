import 'package:flutter/material.dart';

class TrackedCitiesScreen extends StatelessWidget {
  const TrackedCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          "Отслеживаемые города",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}