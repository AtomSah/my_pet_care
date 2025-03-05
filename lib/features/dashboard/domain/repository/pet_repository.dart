// lib/features/dashboard/domain/repository/pet_repository.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/dashboard/data/data_source/pet_data_source.dart';
import 'package:pet_care/features/dashboard/domain/entity/pet_entity.dart';

abstract class IPetRepository {
  Future<Either<Failure, List<PetEntity>>> getAllPets();
  Future<Either<Failure, List<PetEntity>>> getPetsByType(String type);
  Future<Either<Failure, PetEntity>> getPetById(String id);
}

class PetRepository implements IPetRepository {
  final IPetDataSource _petDataSource;

  PetRepository(this._petDataSource);

  @override
  Future<Either<Failure, List<PetEntity>>> getAllPets() async {
    try {
      final result = await _petDataSource.getAllPets();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, List<PetEntity>>> getPetsByType(String type) async {
    try {
      final result = await _petDataSource.getPetsByType(type);
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, PetEntity>> getPetById(String id) async {
    try {
      final result = await _petDataSource.getPetById(id);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}