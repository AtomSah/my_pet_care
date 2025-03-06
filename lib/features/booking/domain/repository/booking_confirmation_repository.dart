// lib/features/booking/domain/repository/booking_confirmation_repository.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/booking/domain/entity/booking_confirmation_entity.dart';

abstract class IBookingConfirmationRepository {
  Future<Either<Failure, void>> confirmBooking(BookingConfirmationEntity bookingData);
}