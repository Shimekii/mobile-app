import 'package:air_check/app/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../select_city/tracked_cities_screen.dart';
import '../aqi_details/aqi_details_screen.dart';

Color getAqiColor(int aqi) {
  if (aqi <= 50) return Colors.green.withValues(alpha: 0.8);
  if (aqi <= 100) return Colors.yellow.shade700.withValues(alpha: 0.8);
  if (aqi <= 150) return Colors.orange.shade600.withValues(alpha: 0.8);
  if (aqi <= 200) return Colors.red.withValues(alpha: 0.8);
  return Colors.purple.withValues(alpha: 0.8);
}

String getAqiLabel(int aqi) {
  if (aqi <= 50) return "ХОРОШО";
  if (aqi <= 100) return "УМЕРЕННО";
  if (aqi <= 150) return "ВРЕДНО";
  if (aqi <= 200) return "НЕЗДОРОВО";
  return "ОПАСНО";
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _MainHomeContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            top: 105,
            left: 0,
            right: 0,
            child: Consumer<AppViewModel>(
                builder: (context, vm, _){
                  final cityName = vm.mainCity?.name ?? "Null";
                  final aqi = vm.mainCity?.aqd.currentAqi ?? 0;
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Город + иконка
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pushNamed(context, "/addMainCity");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                cityName,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        // Цифра AQI + колонка справа
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Цифра AQI
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                vm.mainCity!.aqd.currentAqi.toString(),
                                style: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(width: 8),

                            // Колонка справа с индикатором и подписью AQI
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 32),
                                // Индикатор качества воздуха
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AqiDetailsScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: getAqiColor(aqi),
                                    ),
                                    child: Text(
                                      getAqiLabel(aqi),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ),

                                // Фиксированный отступ между индикатором и подписью AQI
                                SizedBox(height: 12), // 100 — размер цифры, 14 — размер индикатора

                                Text(
                                  "AQI",
                                  style: TextStyle(
                                      fontSize: 40,
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
            bottom: 80,
            left: 18,
            right: 18,
            child: Consumer<AppViewModel>(
              builder: (context, vm, _) {
                final forecast = vm.mainCity?.aqd.forecast;
                final isForecastLoaded = forecast != null && forecast.isNotEmpty;
                String msg = "";
                if (forecast == null) {
                  msg = "Загрузка прогноза...";
                }
                else if (forecast.isEmpty) {
                  msg = "Не удалось загрузить прогноз";
                }
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(59, 0, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(left: 8, bottom: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 20,
                            ),
                            //SizedBox(width: width * 0.02),
                            Text(
                              "Прогноз на 5 дней",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )
                            )
                          ]
                        )
                      ),

                      if (!isForecastLoaded)
                      Container (
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            msg,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ),
                      )
                      
                      else 
                      //Отдельные строчки
                      ...List.generate(forecast.length, (index) {
                        final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
                        final today = DateTime.now().weekday - 1;
                        final dayIndex = (today + index) % 7;

                        final aqiValues = forecast[index];



                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 18,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),

                              const Spacer(),
                              
                              //Цветовой индикатор
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: getAqiColor(aqiValues),
                              ),

                              SizedBox(width: 8),

                              //Уровень AQI
                              SizedBox(
                                width: 72,
                                child: Text(
                                  "$aqiValues AQI",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
                );
              }
            )
          ),
        ]
    );
  }
}


class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // общий фон
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),


          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: [
              _MainHomeContent(),
              TrackedCitiesScreen(),
            ],
          ),

          // индикатор
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(0),
                SizedBox(width: 8),
                _buildDot(1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: currentPage == index ? 10 : 8,
      height: currentPage == index ? 10 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index
            ? Colors.white
            : Colors.white.withValues(alpha: 0.5),
      ),
    );
  }
}
