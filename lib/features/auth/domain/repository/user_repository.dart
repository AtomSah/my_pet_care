import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> createUser(UserEntity userEntity);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, void>> deleteUser(String id);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
