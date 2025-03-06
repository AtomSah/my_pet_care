// lib/features/booking/presentation/view_model/booking_confirmation_event.dart

abstract class BookingConfirmationEvent {}

class ConfirmBookingEvent extends BookingConfirmationEvent {
  final String name;
  final String phone;
  final String location;

  ConfirmBookingEvent({
    required this.name,
    required this.phone,
    required this.location,
  });
}