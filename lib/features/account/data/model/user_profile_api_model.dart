import 'package:pet_care/features/account/domain/entity/user_profile_entity.dart';

class UserProfileApiModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileApiModel.fromJson(Map<String, dynamic> json) {
    return UserProfileApiModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '',
      role: json['role'],
      avatar: json['avatar'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatar': avatar,
    };
  }

  UserProfileEntity toEntity() => UserProfileEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        role: role,
        avatar: avatar,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}