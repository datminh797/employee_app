part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadFail extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final Note note;

  const HomeLoadSuccess(this.note);

  @override
  List<Object?> get props => [note];
}
