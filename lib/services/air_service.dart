import 'dart:convert';
import 'package:http/http.dart' as http;

class AirService {
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
      final responce = await http.get(url);

      if (responce.statusCode == 200) {
        final data = json.decode(responce.body);

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
}