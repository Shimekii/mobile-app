import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String imagePath;

  const OnboardingPage({required this.title, required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // фон
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover, // растянуть на весь экран
            ),
          ),
        ),
        // контент поверх
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}