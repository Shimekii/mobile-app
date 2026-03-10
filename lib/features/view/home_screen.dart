import 'package:air_check/app/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                fontSize: 100,
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
                              SizedBox(height: height * 0.04),
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
                              SizedBox(height: height * 0.014), // 100 — размер цифры, 14 — размер индикатора

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

          //Таблица с прогнозом
          Positioned(
            bottom: height * 0.1,
            left: width * 0.05,
            right: width * 0.05,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.04,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: width * 0.02, bottom: height * 0.015),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: width * 0.05,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Прогноз на 5 дней",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500,
                          )
                        )
                      ]
                    )
                  ),

                  //Отдельные строчки
                  ...List.generate(5, (index) {
                    final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
                    final today = DateTime.now().weekday - 1;
                    final dayIndex = (today + index) % 7;
                    //Тестовые значения
                    final mockAqi = [23, 34, 55, 80, 112][index];

                    //Цвет в соответствии с уровнем AQI
                    Color getAqiColor(int aqi) {
                      if (aqi <= 50) return Colors.green;
                      if (aqi <= 100) return Colors.yellow;
                      if (aqi <= 150) return Colors.orange;
                      if (aqi <= 200) return Colors.red;
                      if (aqi <= 300) return Colors.purple;
                      return Colors.brown;
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: height * 0.015),
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                        horizontal: width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          //День недели
                          Text(
                            days[dayIndex],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w500
                            ),
                          ),

                          const Spacer(),
                          
                          //Цветовой индикатор
                          CircleAvatar(
                            radius: width * 0.02,
                            backgroundColor: getAqiColor(mockAqi),
                          ),

                          SizedBox(width: width * 0.02),

                          //Уровень AQI
                          SizedBox(
                            width: width * 0.2,
                            child: Text(
                              "$mockAqi AQI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            )
                          )
                        ]
                      )
                    );
                  })
                ]
              )
            )
          )
        ]
      )
    );
  }
} 