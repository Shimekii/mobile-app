import 'package:flutter/material.dart';

class TrackedCitiesScreen extends StatelessWidget {
  const TrackedCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // фон
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // содержимое
          Column(
            children: [
              SizedBox(height: 70),

              // заголовок списка + кнопка добавления города в список
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Отслеживаемые города",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Spacer(),

                    // кнопка
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/addMainCity");
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}