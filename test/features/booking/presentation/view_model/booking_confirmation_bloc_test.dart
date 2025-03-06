import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:pet_care/features/booking/domain/entity/booking_confirmation_entity.dart';
import 'package:pet_care/features/booking/domain/repository/booking_confirmation_repository.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_bloc.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_event.dart';
import 'package:pet_care/features/booking/presentation/view_model/booking_confirmation_state.dart';

// Mocking the repository
class MockBookingConfirmationRepository extends Mock
    implements IBookingConfirmationRepository {}

void main() {
  late BookingConfirmationBloc bloc;
  late MockBookingConfirmationRepository mockRepository;

  setUp(() {
    mockRepository = MockBookingConfirmationRepository();
    bloc = BookingConfirmationBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  const testBooking = BookingConfirmationEntity(
    petId: '123',
    name: 'John Doe',
    phone: '9876543210',
    location: 'New York',
  );

  group('BookingConfirmationBloc', () {
    test('initial state is BookingConfirmationInitial', () {
      expect(bloc.state, equals(BookingConfirmationInitial()));
    });

    blocTest<BookingConfirmationBloc, BookingConfirmationState>(
      'emits [BookingConfirmationLoading, BookingConfirmationSuccess] when booking is successful',
      build: () {
        when(() => mockRepository.confirmBooking(testBooking))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(ConfirmBookingEvent(
        petId: '123',
        name: 'John Doe',
        phone: '9876543210',
        location: 'New York',
      )),
      expect: () => [
        BookingConfirmationLoading(),
        BookingConfirmationSuccess(),
      ],
      verify: (_) {
        verify(() => mockRepository.confirmBooking(testBooking)).called(1);
      },
    );

    blocTest<BookingConfirmationBloc, BookingConfirmationState>(
      'emits [BookingConfirmationLoading, BookingConfirmationError] when booking fails',
      build: () {
        when(() => mockRepository.confirmBooking(testBooking)).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Booking failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(ConfirmBookingEvent(
        petId: '123',
        name: 'John Doe',
        phone: '9876543210',
        location: 'New York',
      )),
      expect: () => [
        BookingConfirmationLoading(),
        BookingConfirmationError(message: 'Booking failed'),
      ],
      verify: (_) {
        verify(() => mockRepository.confirmBooking(testBooking)).called(1);
      },
    );
  });
}
