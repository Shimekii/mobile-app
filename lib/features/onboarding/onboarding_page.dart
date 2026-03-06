import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const OnboardingPage({
    required this.title, 
    required this.imagePath, 
    required this.description,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100), // отступ сверху
            // Картинка с реальными размерами
            Image.asset(
              imagePath,
              width: 158,   // ставишь нужную ширину
              height: 158,  // ставишь нужную высоту
              fit: BoxFit.contain, // сохраняет пропорции
            ),
            SizedBox(height: 20),
            // Заголовок
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 32),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
      ],
    );
  }
}