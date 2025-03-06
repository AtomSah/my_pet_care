// lib/features/booking/domain/entity/booking_confirmation_entity.dart

import 'package:equatable/equatable.dart';

class BookingConfirmationEntity extends Equatable {
  final String name;
  final String phone;
  final String location;

  const BookingConfirmationEntity({
    required this.name,
    required this.phone,
    required this.location,
  });

  @override
  List<Object?> get props => [name, phone, location];
}