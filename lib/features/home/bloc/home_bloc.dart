import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../core/enums/request_status.dart';
import '../../../core/errors/failure.dart';
import '../data/models/home_respone.dart';
import '../data/repository/repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(const HomeState(status: RequestStatus.loading));

      final result = await repository.home();

      result.fold(
        (failure) {
          emit(HomeState(status: RequestStatus.error, message: failure.message));
        },
        (response) {
          final success = response.data != null;
          emit(HomeState(
            status: success ? RequestStatus.success : RequestStatus.error,
            response: success ? response : null,
          ));
        },
      );
    });

    on<HomeClearEvent>((event, emit) {
      emit(const HomeState());
    });
  }
}
