import 'package:dio/dio.dart';
import 'package:oho_cart/src/constants/api_constants.dart';
import 'package:oho_cart/src/models/auth/request/login_request.dart';

import 'package:oho_cart/src/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Response> login(LoginRequest loginRequest) async {
    try {
      final Response response = await _dio.post(
        BASE_URL + LOGIN,
        data: {
          "username": "atuny0",
          "password": "9uQFF1Lh",
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<User> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final Response response = await _dio.get(
        BASE_URL + PROFILE,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      return User.fromJson(e.response!.data);
    }
  }

  Future<Response> register(String email, String password) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/register',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> forgotPassword(String email) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/forgot-password',
        data: {
          'email': email,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> resetPassword(String email, String password) async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/reset-password',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateProfile(String name, String email) async {
    try {
      final Response response = await _dio.put(
        'https://api.example.com/profile',
        data: {
          'name': name,
          'email': email,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final Response response = await _dio.put(
        'https://api.example.com/change-password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> logout() async {
    try {
      final Response response = await _dio.post(
        'https://api.example.com/logout',
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
