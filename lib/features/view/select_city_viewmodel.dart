import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/models/city.dart';
import 'package:air_check/repositories/air_quality_data.dart';
import 'package:air_check/repositories/city_repository.dart';
import 'package:air_check/services/city_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityView extends StatelessWidget {
  const SelectCityView({super.key});

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
                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                          final coords = await cityService.getCoordByName(city);
                            if (coords == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Город не найден')),
                              );
                              return;
                            }

                            final newCity = City(city, AirQualityData.empty(), coords);
                            vm.setMainCity(newCity);
                            vm.getAqi();
                            await vm.saveMainCity();
                            Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3.5,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 16,
                          ),
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