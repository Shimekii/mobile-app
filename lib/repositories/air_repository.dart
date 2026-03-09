import 'package:air_check/models/city.dart';
import 'package:air_check/models/coordinates.dart';
import 'package:air_check/repositories/air_quality_data.dart';
import 'package:air_check/services/air_service.dart';
import 'package:air_check/services/city_service.dart';

class AirRepository {
  final airService = AirService();
  final cityService = CityService();

  Future<AirQualityData> loadAirQualityByCoord(Coordinates coord) async {
    int? aqi = await airService.fetchCurrent(coord.lat, coord.lon);

    return AirQualityData(
      aqi: aqi ?? 0,
    );
  }

  Future<(Coordinates, AirQualityData)> loadAirQualityByCity(String name) async {
    Coordinates? city = await cityService.getCoordByName(name);

    if (city == null) {
      throw Exception("City not found");
    }

    int? aqi = await airService.fetchCurrent(city.lat, city.lon);

    return (
      city,
      AirQualityData(aqi: aqi ?? 0),
    );
  }
}