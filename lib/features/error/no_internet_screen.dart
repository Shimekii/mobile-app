import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>{
  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Stack(
        children: [
          Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/onboarding_background.jpeg"),
                    fit: BoxFit.cover,
                  )
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 240),
              Row(
                children: [
                  Text(
                    "ОШИБКА!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 88,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(width: 12),
              
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:  Text(
                "Отсутствует подключение к интернету",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
             )
            ],
          )

        ]
      )
    );
  }
}