import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/user_location.dart';
import '../../domain/use_case/get_user_location_use_case.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  GetUserLocationUseCase getUserLocationUseCase;

  LocationBloc({required this.getUserLocationUseCase}) : super(LocationInitial()) {
    on<GetLocation>(_getLocation);
  }

  Future<void> _getLocation(GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final location = await getUserLocationUseCase.call();

      if (location != null) {
        emit(LocationLoaded(location));
      } else {
        emit(
          LocationLoadedDefault(
            UserLocation(
              latitude: 0,
              longitude: 0,
              provinceName: 'Toàn Quốc',
            ),
          ),
        );
      }
    } catch (error) {
      emit(LocationLoadFail(error.toString()));
    }
  }
}
