import 'package:dio/dio.dart';
import 'package:pet_care/app/constants/api_endpoints.dart';
import 'package:pet_care/features/account/data/model/user_profile_api_model.dart';

abstract class IAccountDataSource {
  Future<UserProfileApiModel> getUserProfile();
  Future<UserProfileApiModel> updateUserProfile(String name, String phone);
  Future<String> uploadProfilePicture(String filePath);
}

class AccountRemoteDataSource implements IAccountDataSource {
  final Dio _dio;

  AccountRemoteDataSource(this._dio);

  @override
  Future<UserProfileApiModel> getUserProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.userProfile);
      if (response.statusCode == 200) {
        return UserProfileApiModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get user profile');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<UserProfileApiModel> updateUserProfile(String name, String phone) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateProfile,
        data: {
          'name': name,
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        return UserProfileApiModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update profile');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<String> uploadProfilePicture(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message'] ?? 'Failed to upload image');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}