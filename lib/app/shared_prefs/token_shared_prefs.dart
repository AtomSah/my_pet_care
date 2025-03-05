// lib/app/shared_prefs/token_shared_prefs.dart

import 'package:dartz/dartz.dart';
import 'package:pet_care/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;
  static const String tokenKey = 'token';
  static const String userIdKey = 'userId';
  static const String userRoleKey = 'userRole';

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString(tokenKey, token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString(tokenKey);
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteToken() async {
    try {
      await _sharedPreferences.remove(tokenKey);
      await _sharedPreferences.remove(userIdKey);
      await _sharedPreferences.remove(userRoleKey);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveUserData(String userId, String role) async {
    try {
      await _sharedPreferences.setString(userIdKey, userId);
      await _sharedPreferences.setString(userRoleKey, role);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString(userIdKey);
      return Right(userId ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getUserRole() async {
    try {
      final role = _sharedPreferences.getString(userRoleKey);
      return Right(role ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> hasToken() async {
    try {
      final token = _sharedPreferences.getString(tokenKey);
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> clearAll() async {
    try {
      await _sharedPreferences.clear();
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}