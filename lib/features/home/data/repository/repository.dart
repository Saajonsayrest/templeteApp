import 'package:dartz/dartz.dart';
import 'package:testing/features/home/data/models/home_respone.dart';

import '../../../../core/errors/failure.dart';
import '../datasource/datasource.dart';

class Repository {
  final HomeDataSource dataSource;

  Repository(this.dataSource);

  Future<Either<Failure, HomeResponse>> home() async {
    try {
      final response = await dataSource.home();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
