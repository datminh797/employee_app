part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class LanguageChangeRequest extends LanguageEvent {
  final Locale language;

  const LanguageChangeRequest(this.language);

  @override
  List<Object?> get props => [language];
}
