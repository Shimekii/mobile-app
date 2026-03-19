import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/models/city.dart';
import 'package:air_check/repositories/city_repository.dart';
import 'package:air_check/services/city_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityView extends StatelessWidget {
  final bool isSelectingForTracking; // флаг дял переключения выбора городов между 'основным' и 'добавлением дополнительного для отслеживания'

  const SelectCityView({
    super.key,
    this.isSelectingForTracking = false,
  });

  @override
  Widget build(BuildContext context) {
    final cityRepository = CityRepository();
    final cityService = CityService();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Column(
            children: [
              SizedBox(height: 70),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Введите название города",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                  ),
                )
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  //height: height * 0.9,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.23),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cityRepository.cities.length,
                    itemBuilder: (context, index) {
                      final city = cityRepository.cities[index];
                      return GestureDetector(
                          onTap: () async {
                            final vm = Provider.of<AppViewModel>(context, listen: false);

                            if (isSelectingForTracking) {
                              final success = await vm.addTrackedCityByName(city);

                              if (!success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Город уже добавлен или не найден')),
                                );
                                return;
                              }

                              Navigator.pop(context);
                            } else {
                              // логика выбора основного города
                              final coords = await cityService.getCoordByName(city);

                              if (coords == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Город не найден')),
                                );
                                return;
                              }

                              final aqd = await vm.airRepository.loadAirQualityByCoord(coords);
                              final newCity = City(city, aqd, coords);

                              vm.setMainCity(newCity);
                              await vm.saveMainCity();
                              Navigator.pushReplacementNamed(context, "/home");
                            }
                          },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}