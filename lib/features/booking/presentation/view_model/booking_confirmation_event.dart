// lib/features/booking_popups/presentation/view_model/booking_confirmation_event.dart

abstract class BookingConfirmationEvent {}

class ConfirmBookingEvent extends BookingConfirmationEvent {
  final String petId;  
  final String name;
  final String phone;
  final String location;

  ConfirmBookingEvent({
    required this.petId,
    required this.name,
    required this.phone,
    required this.location,
  });
}