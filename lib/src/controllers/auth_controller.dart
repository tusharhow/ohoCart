import 'package:flutter/material.dart';
import 'package:oho_cart/src/models/auth/request/login_request.dart';
import 'package:oho_cart/src/models/auth/response/login_response.dart';
import 'package:oho_cart/src/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    setLoading(true);
    final response = await AuthService().login(LoginRequest(
        username: loginRequest.username, password: loginRequest.password));
    setLoading(false);
    if (response.statusCode == 200) {
      final LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      saveToken(loginResponse.token.toString());
      return loginResponse;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<User> getUser() async {
    setLoading(true);
    final user = await AuthService().getProfile();
    setLoading(false);
    return user;
  }
}
