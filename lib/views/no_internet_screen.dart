import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>{
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

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
              SizedBox(height: height * 0.3),
              Row(
                children: [
                  Text(
                    "ОШИБКА!",
                    style: TextStyle(
                      fontSize: width * 0.089,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width * 0.033),
                  Container(
                    width: width * 0.11,
                    height: height * 0.11,
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
                          fontSize: width * 0.067,
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(width: width * 0.033),
              
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Отсутствует подключение к интернету",
                style: TextStyle(
                  fontSize: width * 0.089,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              )
            ],
          )

        ]
      )
    );
  }
}