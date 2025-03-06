// lib/features/booking/presentation/view_model/booking_confirmation_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/features/booking_popups/domain/entity/booking_confirmation_entity.dart';
import 'package:pet_care/features/booking_popups/domain/repository/booking_confirmation_repository.dart';
import 'package:pet_care/features/booking_popups/presentation/view_model/booking_confirmation_event.dart';
import 'package:pet_care/features/booking_popups/presentation/view_model/booking_confirmation_state.dart';

class BookingConfirmationBloc
    extends Bloc<BookingConfirmationEvent, BookingConfirmationState> {
  final IBookingConfirmationRepository _repository;

  BookingConfirmationBloc({
    required IBookingConfirmationRepository repository,
  })  : _repository = repository,
        super(BookingConfirmationInitial()) {
    on<ConfirmBookingEvent>(_onConfirmBooking);
  }

  Future<void> _onConfirmBooking(
    ConfirmBookingEvent event,
    Emitter<BookingConfirmationState> emit,
  ) async {
    emit(BookingConfirmationLoading());

    final result = await _repository.confirmBooking(
      BookingConfirmationEntity(
        petId: event.petId,
        name: event.name,
        phone: event.phone,
        location: event.location,
      ),
    );

    result.fold(
      (failure) => emit(BookingConfirmationError(message: failure.message)),
      (_) => emit(BookingConfirmationSuccess()),
    );
  }
}
