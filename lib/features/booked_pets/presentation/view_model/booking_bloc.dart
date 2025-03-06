import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/features/booked_pets/domain/repository/booking_repository.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_event.dart';
import 'package:pet_care/features/booked_pets/presentation/view_model/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final IBookingRepository _bookingRepository;

  BookingBloc({required IBookingRepository bookingRepository})
      : _bookingRepository = bookingRepository,
        super(BookingInitial()) {
    on<CreateBookingEvent>(_onCreateBooking);
    on<GetUserBookingsEvent>(_onGetUserBookings);
    on<GetAllBookingsEvent>(_onGetAllBookings);
    on<UpdateBookingStatusEvent>(_onUpdateBookingStatus);
  }

  Future<void> _onCreateBooking(
    CreateBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await _bookingRepository.createBooking(
      event.petId,
      event.name,
      event.contact,
      event.address,
    );
    result.fold(
      (failure) => emit(BookingError(message: failure.message)),
      (booking) => emit(BookingCreated(booking: booking)),
    );
  }

  Future<void> _onGetUserBookings(
    GetUserBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await _bookingRepository.getUserBookings();
    result.fold(
      (failure) => emit(BookingError(message: failure.message)),
      (bookings) => emit(UserBookingsLoaded(bookings: bookings)),
    );
  }

  Future<void> _onGetAllBookings(
    GetAllBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await _bookingRepository.getAllBookings();
    result.fold(
      (failure) => emit(BookingError(message: failure.message)),
      (bookings) => emit(AllBookingsLoaded(bookings: bookings)),
    );
  }

  Future<void> _onUpdateBookingStatus(
    UpdateBookingStatusEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final result = await _bookingRepository.updateBookingStatus(
      event.bookingId,
      event.status,
    );
    result.fold(
      (failure) => emit(BookingError(message: failure.message)),
      (booking) => emit(BookingStatusUpdated(booking: booking)),
    );
  }
}
