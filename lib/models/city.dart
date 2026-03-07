import 'package:air_check/models/coordinates.dart';
import 'package:air_check/repositories/air_quality_data.dart';

class City {
  final Coordinates coordinates;
  final String name;
  AirQualityData aqd;
  City(this.name, this.aqd, this.coordinates);
  
  void updateCurrent(AirQualityData aqd){
    this.aqd = aqd;
  }
}