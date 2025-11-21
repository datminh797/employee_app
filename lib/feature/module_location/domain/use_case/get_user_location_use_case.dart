import '../entity/user_location.dart';
import '../repository/user_location_repository.dart';

class GetUserLocationUseCase {
  UserLocationRepository userLocationRepository;

  GetUserLocationUseCase(this.userLocationRepository);

  Future<UserLocation?> call() async {
    final userLocation = await userLocationRepository.getUserLocation();

    return userLocation;
  }
}
