import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageChanged> {
  LanguageBloc() : super(const LanguageChanged(locale: Locale('vi'))) {
    on<LanguageChangeRequest>((event, emit) {
      emit(LanguageChanged(locale: event.language));
    });
  }
}
