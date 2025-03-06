// lib/features/booking_popups/domain/repository/booking_confirmation_repository.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/booking_popups/data/data_source/booking_confirmation_data_source.dart';
import 'package:pet_care/features/booking_popups/domain/entity/booking_confirmation_entity.dart';

abstract class IBookingConfirmationRepository {
  Future<Either<Failure, void>> confirmBooking(BookingConfirmationEntity bookingData);
}

class BookingConfirmationRepository implements IBookingConfirmationRepository {
  final IBookingConfirmationDataSource _dataSource;

  BookingConfirmationRepository(this._dataSource);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingConfirmationEntity bookingData) async {
    try {
      await _dataSource.confirmBooking(bookingData);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}