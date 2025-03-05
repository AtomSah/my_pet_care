
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetUserProfileEvent extends AccountEvent {}

class UpdateUserProfileEvent extends AccountEvent {
  final String name;
  final String phone;

  const UpdateUserProfileEvent({
    required this.name,
    required this.phone,
  });

  @override
  List<Object> get props => [name, phone];
}

class UploadProfilePictureEvent extends AccountEvent {
  final String filePath;

  const UploadProfilePictureEvent({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class LogoutEvent extends AccountEvent {}