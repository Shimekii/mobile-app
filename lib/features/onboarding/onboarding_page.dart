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
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05), // отступ сверху
            // Картинка с реальными размерами
            Image.asset(
              imagePath,
              width: width * 0.4,   // ставишь нужную ширину
              height: height * 0.4,  // ставишь нужную высоту
              fit: BoxFit.contain, // сохраняет пропорции
            ),
            SizedBox(height: height * 0.015),
            // Заголовок
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.075,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: height * 0.04),
            Text(
              description,
              style: TextStyle(
                fontSize: width * 0.05,
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