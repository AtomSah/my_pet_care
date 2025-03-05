import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/features/booking/data/model/booking_api_model.dart';

abstract class IBookingDataSource {
  Future<List<BookingApiModel>> getUserBookings();
  Future<BookingApiModel> createBooking(String petId, String name, String contact, String address);
  Future<List<BookingApiModel>> getAllBookings();
  Future<BookingApiModel> updateBookingStatus(String bookingId, String status);
}

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  @override
  Future<List<BookingApiModel>> getUserBookings() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUserBookings);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => BookingApiModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<BookingApiModel> createBooking(
    String petId,
    String name,
    String contact,
    String address,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createBooking,
        data: {
          'petId': petId,
          'name': name,
          'contact': contact,
          'address': address,
        },
      );
      if (response.statusCode == 201) {
        return BookingApiModel.fromJson(response.data['booking']);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<BookingApiModel>> getAllBookings() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllBookings);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => BookingApiModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<BookingApiModel> updateBookingStatus(String bookingId, String status) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.updateBookingStatus}/$bookingId',
        data: {'status': status},
      );
      if (response.statusCode == 200) {
        return BookingApiModel.fromJson(response.data['booking']);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}