import '../entity/user_location.dart';

abstract class UserLocationRepository {
  Future<UserLocation?> getUserLocation();
}
