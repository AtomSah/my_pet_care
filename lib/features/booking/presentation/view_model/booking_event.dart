import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  final String petId;
  final String name;
  final String contact;
  final String address;

  const CreateBookingEvent({
    required this.petId,
    required this.name,
    required this.contact,
    required this.address,
  });

  @override
  List<Object> get props => [petId, name, contact, address];
}

class GetUserBookingsEvent extends BookingEvent {}

class GetAllBookingsEvent extends BookingEvent {}

class UpdateBookingStatusEvent extends BookingEvent {
  final String bookingId;
  final String status;

  const UpdateBookingStatusEvent({
    required this.bookingId,
    required this.status,
  });

  @override
  List<Object> get props => [bookingId, status];
}

