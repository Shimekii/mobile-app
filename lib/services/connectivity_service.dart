import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> hasInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none){
      return false;
    }

    try {
      final result = await InternetAddress.lookup("open-meteo.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        return true;
      }
      else {
        return false;
      }
    } on SocketException catch(_){
      return false;
    }
  }
}