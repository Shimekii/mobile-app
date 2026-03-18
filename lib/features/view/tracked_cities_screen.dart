import 'package:flutter/material.dart';
import 'select_city_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:air_check/app/app_viewmodel.dart';

class TrackedCitiesScreen extends StatelessWidget {
  const TrackedCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [

          // содержимое
          Column(
            children: [
              SizedBox(height: 70),

              // кнопка добавления дополнительного города в список
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectCityView(isSelectingForTracking: true),
                          ),
                        );
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

              SizedBox(height: 20),

              // плашка (для списка городов)
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.23),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      // заголовок внутри плашки
                      Text(
                        "Отслеживаемые города",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 6),

                      // список городов отслеживаемых
                      Expanded(
                        // child: Container(), // пока пусто
                        child: _buildCitiesList(context),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCitiesList(BuildContext context) {
    final vm = Provider.of<AppViewModel>(context);
    final cities = vm.trackedCities;

    Color getAqiColor(int aqi) {
      if (aqi <= 50) return Colors.green;
      if (aqi <= 100) return Colors.yellow;
      if (aqi <= 150) return Colors.orange;
      if (aqi <= 200) return Colors.red;
      if (aqi <= 300) return Colors.purple;
      return Colors.brown;
    }

    if (cities.isEmpty) {
      return Center(
        child: Text(
          "Пока нет добавленных городов для отслеживания",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // название города
              Text(
                city.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              Spacer(),

              // кружок-индикатор
              CircleAvatar(
                radius: 8,
                backgroundColor: getAqiColor(city.aqd.aqi),
              ),

              SizedBox(width: 8),

              // AQI
              Text(
                "${city.aqd.aqi} AQI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}