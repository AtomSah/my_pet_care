import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/booking/data/data_source/booking_data_source.dart';
import 'package:pet_care/features/booking/domain/entity/booking_entity.dart';

abstract class IBookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getUserBookings();
  Future<Either<Failure, BookingEntity>> createBooking(
    String petId,
    String name,
    String contact,
    String address,
  );
  Future<Either<Failure, List<BookingEntity>>> getAllBookings();
  Future<Either<Failure, BookingEntity>> updateBookingStatus(
    String bookingId,
    String status,
  );
}

class BookingRepository implements IBookingRepository {
  final IBookingDataSource _bookingDataSource;

  BookingRepository(this._bookingDataSource);

  @override
  Future<Either<Failure, List<BookingEntity>>> getUserBookings() async {
    try {
      final result = await _bookingDataSource.getUserBookings();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, BookingEntity>> createBooking(
    String petId,
    String name,
    String contact,
    String address,
  ) async {
    try {
      final result = await _bookingDataSource.createBooking(
        petId,
        name,
        contact,
        address,
      );
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getAllBookings() async {
    try {
      final result = await _bookingDataSource.getAllBookings();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, BookingEntity>> updateBookingStatus(
    String bookingId,
    String status,
  ) async {
    try {
      final result = await _bookingDataSource.updateBookingStatus(bookingId, status);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 400));
    }
  }
}