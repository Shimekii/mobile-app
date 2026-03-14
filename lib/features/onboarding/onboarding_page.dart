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
            SizedBox(height: 40), // отступ сверху
            // Картинка с реальными размерами
            Image.asset(
              imagePath,
              width: 144,   // ставишь нужную ширину
              height: 320,  // ставишь нужную высоту
              fit: BoxFit.contain, // сохраняет пропорции
            ),
            SizedBox(height: 12),
            // Заголовок
            Text(
              title,
              style: TextStyle(
                fontSize: 27,
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
                fontSize: 18,
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