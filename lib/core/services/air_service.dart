import 'dart:convert';
import 'package:http/http.dart' as http;

class AirCurrentData {
  final int usAqi;
  final double? pm25;
  final double? pm10;
  final double? so2;
  final double? no2;
  final double? o3;
  final double? co;

  AirCurrentData({
    required this.usAqi,
    this.pm25,
    this.pm10,
    this.so2,
    this.no2,
    this.o3,
    this.co,
  });
}

class AirService {
  Future<AirCurrentData?> fetchCurrentDetails(double lat, double lon) async {
  try {
    final url = Uri.https(
      'air-quality-api.open-meteo.com',
      '/v1/air-quality',
      {
        'latitude': lat.toString(),
        'longitude': lon.toString(),
        'current':
            'us_aqi,pm2_5,pm10,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone',
        'timezone': 'auto',
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['current'] != null && data['current'].isNotEmpty) {
        final current = data['current'];

        return AirCurrentData(
          usAqi: ((current['us_aqi'] as num?) ?? 0).round(),
          pm25: (current['pm2_5'] as num?)?.toDouble(),
          pm10: (current['pm10'] as num?)?.toDouble(),
          co: (current['carbon_monoxide'] as num?)?.toDouble(),
          no2: (current['nitrogen_dioxide'] as num?)?.toDouble(),
          so2: (current['sulphur_dioxide'] as num?)?.toDouble(),
          o3: (current['ozone'] as num?)?.toDouble(),
        );
      } else {
        print("Текущие детальные данные о воздухе не найдены");
        return null;
      }
    } else {
      print("Ошибка сервера при получении детальных данных: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Ошибка при получении детальных данных: $e");
    return null;
  }
}
  
  Future<int?> fetchCurrent(double lat, double lon) async {
    try{
      final url = Uri.https(
        'air-quality-api.open-meteo.com',
        '/v1/air-quality',
        {
          'latitude': lat.toString(),
          'longitude': lon.toString(),
          'current': 'us_aqi',
          'timezone': 'auto',
        },
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['current'] != null && data['current'].isNotEmpty){
          int aqi = int.parse(data['current']['us_aqi'].toString());
          return aqi;
        } else {
          // город не найден
          return null;
        }
      }
      else {
        // ошибка сервера
        return null;
      }
    }
    catch (e){
      // ошибка при получении координат
      return null;
    }
  }

  Future<List<int>?> fetchForecast(double lat, double lon) async {
    try {
      final url = Uri.https(
        'air-quality-api.open-meteo.com',
        '/v1/air-quality',
        {
          'latitude': lat.toString(),
          'longitude': lon.toString(),
          'timezone': 'auto',
          'hourly': 'us_aqi'
        }
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['hourly'] != null && data['hourly']['time'] != null && data['hourly']['us_aqi'] != null) {
          final List<dynamic> rawAqi = data['hourly']['us_aqi'];
          final List<int> aqiWeek = [];
          for (var i in rawAqi) {
            if (i != null) {
              aqiWeek.add(i as int);
            }
          }
          if (aqiWeek.isEmpty) {
            print("Пустой прогноз");
            return [];
          }

          List<int> forecast = [];
          for (int i = 0; i < aqiWeek.length; i += 24) {
            int end = i + 24;
            if (end > aqiWeek.length) {
              end = aqiWeek.length;
            }
            int sum = 0, count = 0;
            for (int j = i; j < end; j++) {
              sum += aqiWeek[j];
              count++;
            }
            forecast.add((sum / count).round());
          }
          return forecast;
        }
        else {
          print("Прогноз не найден");
          return [];
        }
      }
      else {
        print("Ошибка сервера");
        return [];
      }
    }
    catch (e) {
      print("Ошибка при получении прогноза");
      return [];
    }
  }
}
