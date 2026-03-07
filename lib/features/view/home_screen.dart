import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/models/city.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final vm = Provider.of<AppViewModel>(context);
    final mainCity = vm.mainCity;
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
          Positioned(
            top: height * 0.13,
            left: 0,
            right: 0,
            child: Consumer<AppViewModel>(
              builder: (context, vm, _){
                final cityName = vm.mainCity?.name ?? "Null";
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Город + иконка
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cityName,
                            style: TextStyle(
                              fontSize: width * 0.089,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: width * 0.07,
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),

                      // Цифра AQI + колонка справа
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Цифра AQI
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              vm.mainCity!.aqd.aqi.toString(),
                              style: TextStyle(
                                fontSize: 200,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(width: width * 0.02),

                          // Колонка справа с индикатором и подписью AQI
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.09),
                              // Индикатор качества воздуха
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.0025,
                                  horizontal: width * 0.025
                                  ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green
                                ),
                                child: Text(
                                  "ХОРОШО", // "Хорошо"
                                  style: TextStyle(
                                    fontSize: width * 0.039,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // Фиксированный отступ между индикатором и подписью AQI
                              SizedBox(height: height * 0.07), // 200 — размер цифры, 14 — размер индикатора

                              Text(
                                "AQI",
                                style: TextStyle(
                                  fontSize: width * 0.11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
} 