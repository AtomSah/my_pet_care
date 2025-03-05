// lib/features/dashboard/data/data_source/pet_data_source.dart

import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/features/dashboard/data/model/pet_api_model.dart';

abstract class IPetDataSource {
  Future<List<PetApiModel>> getAllPets();
  Future<List<PetApiModel>> getPetsByType(String type);
  Future<PetApiModel> getPetById(String id);
}

class PetRemoteDataSource implements IPetDataSource {
  final Dio _dio;

  PetRemoteDataSource(this._dio);

  @override
  Future<List<PetApiModel>> getAllPets() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllPets);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PetApiModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<PetApiModel>> getPetsByType(String type) async {
    try {
      final response = await _dio.get('${ApiEndpoints.getPetsByType}/$type');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PetApiModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<PetApiModel> getPetById(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.getPetById}/$id');
      if (response.statusCode == 200) {
        return PetApiModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}