import 'package:air_check/services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
    final LocationService locationService = LocationService();

    Future<bool> requestLocationPermission() async {
        return await locationService.requestPermission();
    }

    Future<Position> getCurrentPosition() async {
        return await locationService.getCoordinates();
    }
}