import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/app/shared_prefs/token_shared_prefs.dart';
import 'package:pet_care/app/usecase/usecase.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/auth/domain/repository/user_repository.dart';

class DeleteUserParams extends Equatable {
  final String userId;

  const DeleteUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class DeleteUserUsecase implements UsecaseWithParams<void, DeleteUserParams> {
  final IUserRepository userRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteUserUsecase(
      {required this.userRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (l) => left(l),
      (token) async {
        return await userRepository.deleteUser(params.userId, token);
      },
    );
  }
}
