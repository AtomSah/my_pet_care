// lib/features/booking_popups/domain/entity/booking_confirmation_entity.dart

import 'package:equatable/equatable.dart';

class BookingConfirmationEntity extends Equatable {
  final String petId;  // Added petId
  final String name;
  final String phone;
  final String location;

  const BookingConfirmationEntity({
    required this.petId,
    required this.name,
    required this.phone,
    required this.location,
  });

  @override
  List<Object> get props => [petId, name, phone, location];
}