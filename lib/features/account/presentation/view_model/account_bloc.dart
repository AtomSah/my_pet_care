import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/app/shared_prefs/token_shared_prefs.dart';
import 'package:pet_care/features/account/domain/entity/user_profile_entity.dart';
import 'package:pet_care/features/account/domain/repository/account_repository.dart';
import 'package:pet_care/features/account/presentation/view_model/account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final IAccountRepository _accountRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  AccountBloc({
    required IAccountRepository accountRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _accountRepository = accountRepository,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(AccountInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<UploadProfilePictureEvent>(_onUploadProfilePicture);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onGetUserProfile(
    GetUserProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _accountRepository.getUserProfile();
    result.fold(
      (failure) => emit(AccountError(message: failure.message)),
      (profile) => emit(AccountLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _accountRepository.updateUserProfile(
      event.name,
      event.phone,
    );
    result.fold(
      (failure) => emit(AccountError(message: failure.message)),
      (profile) => emit(AccountUpdated(profile: profile)),
    );
  }

  Future<void> _onUploadProfilePicture(
    UploadProfilePictureEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _accountRepository.uploadProfilePicture(event.filePath);
    result.fold(
      (failure) => emit(AccountError(message: failure.message)),
      (imageUrl) {
        add(GetUserProfileEvent()); // Refresh profile after upload
        emit(ProfilePictureUploaded(imageUrl: imageUrl));
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AccountState> emit,
  ) async {
    final result = await _tokenSharedPrefs.deleteToken();
    result.fold(
      (failure) => emit(AccountError(message: failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}