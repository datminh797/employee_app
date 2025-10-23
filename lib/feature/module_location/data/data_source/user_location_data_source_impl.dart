// import 'package:employee_app/feature/module_location/data/data_source/user_location_data_source.dart';
// import 'package:employee_app/feature/module_location/data/model/user_location_model.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../../../core/utils/logger_config.dart';
//
// class UserLocationDataSourceImpl extends UserLocationDataSource {
//   @override
//   Future<UserLocationModel?> getUserLocation() async {
//     final bool isLocationPermissionGranted = await checkUserPermission();
//     if (!isLocationPermissionGranted) {
//       return null;
//     } else {
//       final position = await Geolocator.getCurrentPosition();
//
//       final latitude = position.latitude;
//       final longitude = position.longitude;
//
//       prt0.d('Fetched user location: Lat: $latitude - Long: $longitude');
//
//       return UserLocationModel(latitude: latitude, longitude: longitude);
//     }
//   }
//
//   Future<bool> checkUserPermission() async {
//     bool isLocationServiceEnabled;
//
//     isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isLocationServiceEnabled) {
//       return false;
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//       return false;
//     }
//     return true;
//   }
// }

import 'package:employee_app/feature/module_location/data/data_source/user_location_data_source.dart';
import 'package:employee_app/feature/module_location/data/model/user_location_model.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/logger_config.dart';

class UserLocationDataSourceImpl extends UserLocationDataSource {
  @override
  Future<UserLocationModel?> getUserLocation() async {
    final bool isLocationPermissionGranted = await checkAndRequestPermission();
    if (!isLocationPermissionGranted) {
      prt0.e('Location permission not granted');
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition();

      final latitude = position.latitude;
      final longitude = position.longitude;

      prt0.d('Fetched user location: Lat: $latitude - Long: $longitude');

      return UserLocationModel(latitude: latitude, longitude: longitude);
    } catch (e) {
      prt0.e('Error getting location: $e');
      return null;
    }
  }

  Future<bool> checkAndRequestPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      prt0.e('Location services are disabled');
      // Optionally, you can prompt user to enable location services
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      prt0.d('Location permission denied, requesting...');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        prt0.e('Location permission denied by user');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      prt0.e('Location permission permanently denied. Please enable in settings.');
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }
}
