import 'package:dartz/dartz.dart';
import 'package:testing/features/auth/data/datasources/auth_datasource.dart';
import 'package:testing/features/auth/data/models/default_response.dart';

import '../../../../core/errors/failure.dart';

class Repository {
  final AuthDataSource dataSource;

  Repository(this.dataSource);

  Future<Either<Failure, DefaultResponse>> login() async {
    try {
      final response = await dataSource.login();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
