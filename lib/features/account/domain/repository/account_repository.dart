import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/account/data/data_source/account_data_source.dart';
import 'package:pet_care/features/account/domain/entity/user_profile_entity.dart';

abstract class IAccountRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile();
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(String name, String phone);
  Future<Either<Failure, String>> uploadProfilePicture(String filePath);
}

class AccountRepository implements IAccountRepository {
  final IAccountDataSource _accountDataSource;

  AccountRepository(this._accountDataSource);

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      final result = await _accountDataSource.getUserProfile();
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(
    String name,
    String phone,
  ) async {
    try {
      final result = await _accountDataSource.updateUserProfile(name, phone);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(String filePath) async {
    try {
      final result = await _accountDataSource.uploadProfilePicture(filePath);
      return Right(result);
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}