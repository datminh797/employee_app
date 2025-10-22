import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String? provinceName;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    required this.provinceName,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        provinceName,
      ];
}
