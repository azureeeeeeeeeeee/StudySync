import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Stream<bool> get onInternetStatusChange async* {
    await for (final result in _connectivity.onConnectivityChanged) {
      if (result == ConnectivityResult.none) {
        yield false;
      } else {
        yield await hasInternetConnection();
      }
    }
  }
}