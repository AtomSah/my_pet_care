// lib/features/pet_details/data/data_source/pet_details_data_source.dart

import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/features/petDetails/data/model/pet_details_model.dart';

abstract class IPetDetailsDataSource {
  Future<PetDetailsModel> getPetDetails(String id);
}

class PetDetailsRemoteDataSource implements IPetDetailsDataSource {
  final Dio _dio;

  PetDetailsRemoteDataSource(this._dio);

  @override
  Future<PetDetailsModel> getPetDetails(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.getPetById}/$id');
      
      if (response.statusCode == 200) {
        return PetDetailsModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get pet details');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}