import 'package:geolocator/geolocator.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/shared_preferences.dart';

abstract class ILocationService {
  Future<dynamic> getUserCurrentLocation();
}

class LocationService extends ILocationService {
  @override
  Future getUserCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final prefs = SharedPreferencesHelper.preferences;
    if (isServiceEnabled == false) {
      return null;
    }
    final checkLocationPermission = await Geolocator.checkPermission();

    if (checkLocationPermission.name == LocationPermission.denied.name) {
      final requestPermission = await Geolocator.requestPermission();

      if (requestPermission.name == LocationPermission.denied.name) {
        prefs.setBool("locationPermission", false);
        prefs.setBool("permissionDeniedForever", false);
        if (prefs.containsKey("latitude")) {
          prefs.remove("latitude");
        }
        if (prefs.containsKey("longitude")) {
          prefs.remove("longitude");
        }
        return null;
      } else if (requestPermission.name ==
          LocationPermission.deniedForever.name) {
        prefs.setBool("locationPermission", false);
        prefs.setBool("permissionDeniedForever", true);
        if (prefs.containsKey("latitude")) {
          prefs.remove("latitude");
        }
        if (prefs.containsKey("longitude")) {
          prefs.remove("longitude");
        }
        return null;
      }
    } else if (checkLocationPermission.name ==
        LocationPermission.deniedForever.name) {
      prefs.setBool("locationPermission", false);
      prefs.setBool("permissionDeniedForever", true);
      if (prefs.containsKey("latitude")) {
        prefs.remove("latitude");
      }
      if (prefs.containsKey("longitude")) {
        prefs.remove("longitude");
      }
      return null;
    }

    prefs.setBool("locationPermission", true);
    prefs.setBool("permissionDeniedForever", false);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    prefs.setDouble("longitude", position.longitude);
    prefs.setDouble("latitude", position.latitude);
    return position;
  }
}
