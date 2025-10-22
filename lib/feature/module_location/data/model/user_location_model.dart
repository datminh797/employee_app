// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../domain/entity/user_location.dart';
//
// class UserLocationModel {
//   final double latitude;
//   final double longitude;
//
//   UserLocationModel({
//     required this.latitude,
//     required this.longitude,
//   });
//
//   // -----------------------------------  ENTITY  -----------------------------------
//   UserLocation toEntity() {
//     return UserLocation(
//       latitude: latitude,
//       longitude: longitude,
//     );
//   }
//
//   factory UserLocationModel.fromEntity(UserLocation userLocation) {
//     return UserLocationModel(
//       latitude: userLocation.latitude,
//       longitude: userLocation.longitude,
//     );
//   }
//   // -----------------------------------  FIRESTORE  -----------------------------------
//   Map<String, dynamic> toFirestore() {
//     return {
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }
//
//   factory UserLocationModel.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//   ) {
//     final data = snapshot.data();
//     return UserLocationModel(
//       latitude: data?['latitude'] as double,
//       longitude: data?['longitude'] as double,
//     );
//   }
// }
// user_location_model.dart

import '../../domain/entity/user_location.dart';

class UserLocationModel {
  final double latitude;
  final double longitude;
  final String? provinceName;
  final String? districtName;

  UserLocationModel({
    required this.latitude,
    required this.longitude,
    this.provinceName,
    this.districtName,
  });

  // Copy with
  UserLocationModel copyWith({
    double? latitude,
    double? longitude,
    String? provinceName,
    String? districtName,
  }) {
    return UserLocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      provinceName: provinceName ?? this.provinceName,
      districtName: districtName ?? this.districtName,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'provinceName': provinceName,
      'districtName': districtName,
    };
  }

  // From JSON
  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      provinceName: json['provinceName'],
      districtName: json['districtName'],
    );
  }

  UserLocation toEntity() {
    return UserLocation(
      latitude: latitude,
      longitude: longitude,
      provinceName: provinceName,
    );
  }
}
