part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  
  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final UserProfileEntity profile;

  const AccountLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class AccountUpdated extends AccountState {
  final UserProfileEntity profile;

  const AccountUpdated({required this.profile});

  @override
  List<Object> get props => [profile];
}

class AccountError extends AccountState {
  final String message;

  const AccountError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfilePictureUploaded extends AccountState {
  final String imageUrl;

  const ProfilePictureUploaded({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class LogoutSuccess extends AccountState {}