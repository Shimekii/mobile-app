import 'dart:async';
import 'package:flutter/material.dart';
import 'package:air_check/services/city_service.dart';

class SelectCityViewModel extends ChangeNotifier {
  final CityService cityService = CityService();

  List<String> cities = [];
  bool isLoading = false;

  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        cities = [];
        notifyListeners();
        return;
      }

      isLoading = true;
      notifyListeners();

      final result = await cityService.searchCities(query);

      cities = result;
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
