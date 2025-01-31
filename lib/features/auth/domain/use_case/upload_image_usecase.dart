import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pet_care/app/usecase/usecase.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/auth/domain/repository/user_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IUserRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}