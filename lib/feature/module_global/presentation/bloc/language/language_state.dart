part of 'language_bloc.dart';

class LanguageChanged extends Equatable {
  final Locale locale;

  const LanguageChanged({required this.locale});

  @override
  List<Object?> get props => [locale];
}
