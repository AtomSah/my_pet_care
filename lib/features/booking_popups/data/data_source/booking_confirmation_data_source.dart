// lib/features/booking_popups/data/data_source/booking_confirmation_data_source.dart

import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/features/booking_popups/domain/entity/booking_confirmation_entity.dart';

abstract class IBookingConfirmationDataSource {
  Future<void> confirmBooking(BookingConfirmationEntity bookingData);
}

class BookingConfirmationRemoteDataSource implements IBookingConfirmationDataSource {
  final Dio _dio;

  BookingConfirmationRemoteDataSource(this._dio);

  @override
  Future<void> confirmBooking(BookingConfirmationEntity bookingData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createBooking,
        data: {
          'petId': bookingData.petId,
          'name': bookingData.name,
          'contact': bookingData.phone,
          'address': bookingData.location,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Failed to create booking');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}