import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:air_check/models/coordinates.dart';

class CityService {
  final String username = "shimeki";
  Future<Coordinates?> getCoordByName(String city) async {
    try{
      final uri = Uri.http(
        'api.geonames.org',
        '/searchJSON',
        {
          'q': city,
          'maxRows': '1',
          'username': username,
        },
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['geonames'] != null && data['geonames'].isNotEmpty){
          final first = data['geonames'][0];
          final double lat = double.parse(first['lat'].toString());
          final double lon = double.parse(first['lng'].toString());
          return Coordinates(lat, lon);
        } else {
          // город не найден
          print("Город не найден");
          return null;
        }
      }
      else {
        // ошибка сервера
        print("Ошибка сервера");
        return null;
      }
    }
    catch (e){
      // ошибка при получении координат
      print("Ошибка при получении координат");
      return null;
    }
  }

  Future<String?> getCityNameByCoord(double lat, double lon) async {
    final url = Uri.http(
      'api.geonames.org',
      '/findNearbyPlaceNameJSON',
      {
        'lat': lat.toString(),
        'lng': lon.toString(),
        'username': username,
      }
    );


    final response = await http.get(url);

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      return data['geonames'][0]['name'];
    }
    return null;
  }
}