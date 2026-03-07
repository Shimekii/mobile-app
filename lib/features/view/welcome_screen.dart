import 'package:air_check/app/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.044),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.25),
                Text(
                  "ДОБРО ПОЖАЛОВАТЬ!",
                  style: TextStyle(
                    fontSize: width * 0.072,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Выберите способ определения местоположения, чтобы начать отслеживание качества воздуха.",
                  style: TextStyle(
                    fontSize: width * 0.048,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
          Positioned(
            bottom: height * 0.1,
            left: width * 0.056,
            right: width * 0.056,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, height * 0.075),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Выбрать город",
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
                SizedBox(height: height * 0.0375),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, height * 0.075),
                  ),
                  onPressed: () async {
                    final vm = context.read<AppViewModel>();
                    bool granted = await vm.requestLocation();

                    if (!mounted) return;

                    if (granted){
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Разрешение на геолокацию отклонено"))
                      );
                    }
                  },
                  child: Text(
                    "Определить местоположение",
                    style: TextStyle(
                      fontSize: width * 0.05,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}