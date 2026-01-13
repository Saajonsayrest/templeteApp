part of '../../home/bloc/home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeClearEvent extends HomeEvent {}
