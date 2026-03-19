import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/models/city.dart';
import 'package:air_check/services/city_service.dart';
import 'select_city_viewmodel.dart';

class SelectCityView extends StatelessWidget {
  final bool isSelectingForTracking;

  const SelectCityView({
    super.key,
    this.isSelectingForTracking = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectCityViewModel(),
      child: _SelectCityViewBody(
        isSelectingForTracking: isSelectingForTracking,
      ),
    );
  }
}

class _SelectCityViewBody extends StatelessWidget {
  final bool isSelectingForTracking;

  const _SelectCityViewBody({
    required this.isSelectingForTracking,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SelectCityViewModel>(context);
    final appVm = Provider.of<AppViewModel>(context, listen: false);
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
                  onChanged: vm.search,
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
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.23),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: vm.isLoading
                      ? Center(child: CircularProgressIndicator())

                      : vm.cities.isEmpty
                      ? Center(
                    child: Text(
                      "Начните вводить название города",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  )

                      : ListView.builder(
                    itemCount: vm.cities.length,
                    itemBuilder: (context, index) {
                      final city = vm.cities[index];

                      return GestureDetector(
                        onTap: () async {
                          if (isSelectingForTracking) {
                            final success =
                            await appVm.addTrackedCityByName(city);

                            if (!success) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                    content:
                                    Text('Город не найден')),
                              );
                              return;
                            }

                            final aqd = await appVm.airRepository
                                .loadAirQualityByCoord(coords);

                            final newCity =
                            City(city, aqd, coords);

                            appVm.setMainCity(newCity);
                            await appVm.saveMainCity();

                            Navigator.pushReplacementNamed(
                                context, "/home");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                255, 255, 255, 0.2),
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
