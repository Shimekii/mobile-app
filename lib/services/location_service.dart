import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
class LocationService {
  Future<bool> requestPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted){
      return true;
    }

    if (status.isDenied || status.isRestricted){
        status = await Permission.location.request();
        return status.isGranted;
    }

    if (status.isPermanentlyDenied){
      openAppSettings();
      return false;
    }

    return false;
  }

  Future<Position> getCoordinates() async {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings
    );
  }
} 