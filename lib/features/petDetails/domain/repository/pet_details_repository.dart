// lib/features/pet_details/domain/repository/pet_details_repository.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/petDetails/data/data_source/pet_details_data_source.dart';
import 'package:pet_care/features/petDetails/domain/entity/pet_details_entity.dart';

abstract class IPetDetailsRepository {
  Future<Either<Failure, PetDetailsEntity>> getPetDetails(String id);
}

class PetDetailsRepository implements IPetDetailsRepository {
  final IPetDetailsDataSource _dataSource;

  PetDetailsRepository(this._dataSource);

  @override
  Future<Either<Failure, PetDetailsEntity>> getPetDetails(String id) async {
    try {
      final result = await _dataSource.getPetDetails(id);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}