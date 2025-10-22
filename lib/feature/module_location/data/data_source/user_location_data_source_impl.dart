import 'package:employee_app/feature/module_location/data/data_source/user_location_data_source.dart';
import 'package:employee_app/feature/module_location/data/model/user_location_model.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationDataSourceImpl extends UserLocationDataSource {
  @override
  Future<UserLocationModel?> getUserLocation() async {
    final bool isLocationPermissionGranted = await checkUserPermission();
    if (!isLocationPermissionGranted) {
      return null;
    } else {
      final position = await Geolocator.getCurrentPosition();
      return UserLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }
  }

  Future<bool> checkUserPermission() async {
    bool isLocationServiceEnabled;

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
