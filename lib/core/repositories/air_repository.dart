import 'package:air_check/core/models/coordinates.dart';
import 'package:air_check/core/repositories/air_quality_data.dart';
import 'package:air_check/core/services/air_service.dart';
import 'package:air_check/core/services/city_service.dart';

class AirRepository {
  final airService = AirService();
  final cityService = CityService();

  Future<AirQualityData> loadAirQualityByCoord(Coordinates coord) async {
    int? aqi = await airService.fetchCurrent(coord.lat, coord.lon);
    List<int>? forecast = await airService.fetchForecast(coord.lat, coord.lon);
    AirCurrentData? details =
      await airService.fetchCurrentDetails(coord.lat, coord.lon);
    return AirQualityData(
      currentAqi: aqi ?? 0,
      forecast: forecast,
      pm25: details?.pm25,
      pm10: details?.pm10,
      so2: details?.so2,
      no2: details?.no2,
      o3: details?.o3,
      co: details?.co,
    );
  }

  Future<(Coordinates, AirQualityData)> loadAirQualityByCity(String name) async {
    Coordinates? city = await cityService.getCoordByName(name);

    if (city == null) {
      throw Exception("City not found");
    }

    int? aqi = await airService.fetchCurrent(city.lat, city.lon);
    List<int>? forecast = await airService.fetchForecast(city.lat, city.lon);
    AirCurrentData? details =
    await airService.fetchCurrentDetails(city.lat, city.lon);
    return (
      city,
      AirQualityData(
        currentAqi: aqi ?? 0,
        forecast: forecast,
        pm25: details?.pm25,
        pm10: details?.pm10,
        so2: details?.so2,
        no2: details?.no2,
        o3: details?.o3,
        co: details?.co,
      ),
    );
  }
}
