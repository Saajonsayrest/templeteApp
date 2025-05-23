part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeResponse? response;
  final RequestStatus status;
  final String? message;

  const HomeState({
    this.response,
    this.status = RequestStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [response, status, message];

  HomeState copyWith({
    HomeResponse? response,
    RequestStatus? status,
    String? message,
  }) {
    return HomeState(
      response: response ?? this.response,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
