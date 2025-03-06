// lib/features/booking/presentation/view_model/booking_confirmation_state.dart

abstract class BookingConfirmationState {}

class BookingConfirmationInitial extends BookingConfirmationState {}

class BookingConfirmationLoading extends BookingConfirmationState {}

class BookingConfirmationSuccess extends BookingConfirmationState {}

class BookingConfirmationError extends BookingConfirmationState {
  final String message;

  BookingConfirmationError({required this.message});
}