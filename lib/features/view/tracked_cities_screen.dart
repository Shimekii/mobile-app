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

              // кнопка добавления дополнительного города в список
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Spacer(),
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

              SizedBox(height: 20),

              // плашка (для списка городов)
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  padding: EdgeInsets.symmetric(vertical: 16),
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

                      SizedBox(height: 12),

                      // список городов отслеживаемых
                      Expanded(
                        // child: Container(), // пока пусто
                        child: _buildCitiesList(),
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

  // пока что мок
  Widget _buildCitiesList() {
    final mockCities = [
      {"name": "Томск", "aqi": 23},
      {"name": "Москва", "aqi": 80},
      {"name": "Новосибирск", "aqi": 55},
    ];

    Color getAqiColor(int aqi) {
      if (aqi <= 50) return Colors.green;
      if (aqi <= 100) return Colors.yellow;
      if (aqi <= 150) return Colors.orange;
      if (aqi <= 200) return Colors.red;
      if (aqi <= 300) return Colors.purple;
      return Colors.brown;
    }

    return ListView.builder(
      itemCount: mockCities.length,
      itemBuilder: (context, index) {
        final city = mockCities[index];

        return Container();
      },
    );
  }
}