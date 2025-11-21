import '../../domain/entity/user_location.dart';
import '../../domain/repository/user_location_repository.dart';
import '../data_source/user_location_data_source.dart';

class UserLocationRepositoryImpl extends UserLocationRepository {
  UserLocationDataSource userLocationDataSource;
  UserLocationRepositoryImpl(this.userLocationDataSource);

  @override
  Future<UserLocation?> getUserLocation() async {
    final userLocationModel = await userLocationDataSource.getUserLocation();
    return userLocationModel?.toEntity();
  }
}
