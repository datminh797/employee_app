import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/note.dart';
import '../../domain/use_case/get_note_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetNoteUseCase getNoteUseCase;

  HomeBloc({required this.getNoteUseCase}) : super(HomeInitial()) {
    on<HomeEvent>(_onGetNote);
  }

  Future<void> _onGetNote(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      //
    } catch (error) {
      //
    }
  }
}
