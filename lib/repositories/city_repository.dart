import 'package:air_check/models/coordinates.dart';
import 'package:air_check/services/city_service.dart';

class CityRepository {
  final List<String> cities = [
    "Москва",
    "Санкт-Петербург",
    "Томск",
    "Таллин",
    "Красноярск",
    "Новосибирск",
    "Уфа",
    "Ростов-На-Дону",
    "Омск",
    "Пермь",
    "Волгоград",
    "Челябинск",
    "Иркутск",
    "Тюмень"
  ];
  final cityService = CityService();

    Future<Coordinates?> fetchCoordinates(String cityName) {
    return cityService.getCoordByName(cityName);
  }
}