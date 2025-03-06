// lib/features/booking/data/model/booking_confirmation_model.dart

import 'package:pet_care/features/booking/domain/entity/booking_confirmation_entity.dart';

class BookingConfirmationModel {
  final String name;
  final String phone;
  final String location;

  BookingConfirmationModel({
    required this.name,
    required this.phone,
    required this.location,
  });

  factory BookingConfirmationModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmationModel(
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'location': location,
    };
  }

  BookingConfirmationEntity toEntity() {
    return BookingConfirmationEntity(
      name: name,
      phone: phone,
      location: location,
    );
  }

  factory BookingConfirmationModel.fromEntity(BookingConfirmationEntity entity) {
    return BookingConfirmationModel(
      name: entity.name,
      phone: entity.phone,
      location: entity.location,
    );
  }
}