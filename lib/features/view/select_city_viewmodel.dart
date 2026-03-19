import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/models/city.dart';
import 'package:air_check/services/city_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SelectCityView extends StatefulWidget {
  final bool isSelectingForTracking; // флаг дял переключения выбора городов между 'основным' и 'добавлением дополнительного для отслеживания'

  const SelectCityView({
    super.key,
    this.isSelectingForTracking = false,
  });

  @override
  State<SelectCityView> createState() => _SelectCityViewState();
}

class _SelectCityViewState extends State<SelectCityView> {
  final cityService = CityService();

  List<String> cities = [];
  bool isLoading = false;

  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) return;

      setState(() => isLoading = true);

      final result = await cityService.searchCities(query);

      setState(() {
        cities = result;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AppViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 70),

              // поиск
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: search,
                  decoration: InputDecoration(
                    hintText: "Введите название города",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.23),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];

                      return GestureDetector(
                        onTap: () async {
                          if (widget.isSelectingForTracking) {
                            final success =
                            await vm.addTrackedCityByName(city);

                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Город уже добавлен или не найден'),
                                ),
                              );
                              return;
                            }

                            Navigator.pop(context);
                          } else {
                            final coords =
                            await cityService.getCoordByName(city);

                            if (coords == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                    Text('Город не найден')),
                              );
                              return;
                            }

                            final aqd = await vm.airRepository
                                .loadAirQualityByCoord(coords);

                            final newCity = City(city, aqd, coords);

                            vm.setMainCity(newCity);
                            await vm.saveMainCity();

                            Navigator.pushReplacementNamed(
                                context, "/home");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3.5),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 16),
                          decoration: BoxDecoration(
                            color:
                            Color.fromRGBO(255, 255, 255, 0.2),
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: Text(
                            city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}