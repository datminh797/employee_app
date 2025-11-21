part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final UserLocation userLocation;

  const LocationLoaded(this.userLocation);

  @override
  List<Object?> get props => [userLocation];
}

class LocationLoadedDefault extends LocationState {
  final UserLocation userLocation;
  const LocationLoadedDefault(this.userLocation);

  @override
  List<Object?> get props => [userLocation];
}

class LocationLoadFail extends LocationState {
  final String errorMessage;

  const LocationLoadFail(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
