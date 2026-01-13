import 'package:dartz/dartz.dart';
import 'package:testing/features/home/models/home_respone.dart';

import '../../core/errors/failure.dart';
import '../auth/models/default_response.dart';
import 'datasource.dart';

class Repository {
  final DataSource dataSource;

  Repository(this.dataSource);

  Future<Either<Failure, DefaultResponse>> login() async {
    try {
      final response = await dataSource.login();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, HomeResponse>> home() async {
    try {
      final response = await dataSource.home();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
