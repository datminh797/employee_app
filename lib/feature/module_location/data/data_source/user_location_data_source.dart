import '../model/user_location_model.dart';

abstract class UserLocationDataSource {
  Future<UserLocationModel?> getUserLocation();
}
