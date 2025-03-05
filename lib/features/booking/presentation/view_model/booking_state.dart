import 'package:equatable/equatable.dart';
import 'package:pet_care/features/booking/domain/entity/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingCreated extends BookingState {
  final BookingEntity booking;

  const BookingCreated({required this.booking});

  @override
  List<Object> get props => [booking];
}

class UserBookingsLoaded extends BookingState {
  final List<BookingEntity> bookings;

  const UserBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

class AllBookingsLoaded extends BookingState {
  final List<BookingEntity> bookings;

  const AllBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

class BookingStatusUpdated extends BookingState {
  final BookingEntity booking;

  const BookingStatusUpdated({required this.booking});

  @override
  List<Object> get props => [booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});

  @override
  List<Object> get props => [message];
}