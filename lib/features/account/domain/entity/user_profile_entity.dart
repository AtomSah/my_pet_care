import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        role,
        avatar,
        createdAt,
        updatedAt,
      ];
}