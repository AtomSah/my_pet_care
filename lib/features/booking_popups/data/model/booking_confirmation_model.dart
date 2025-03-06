// lib/features/booking/data/model/booking_confirmation_model.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/features/booking_popups/domain/entity/booking_confirmation_entity.dart';

class BookingConfirmationModel {
  final String petId;
  final String name;
  final String phone;
  final String location;

  BookingConfirmationModel({
    required this.petId,
    required this.name,
    required this.phone,
    required this.location,
  });

  factory BookingConfirmationModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmationModel(
      petId: json['petId'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'name': name,
      'phone': phone,
      'location': location,
    };
  }

  BookingConfirmationEntity toEntity() {
    return BookingConfirmationEntity(
      petId: petId,
      name: name,
      phone: phone,
      location: location,
    );
  }

  factory BookingConfirmationModel.fromEntity(BookingConfirmationEntity entity) {
    return BookingConfirmationModel(
      petId: entity.petId,
      name: entity.name,
      phone: entity.phone,
      location: entity.location,
    );
  }
}