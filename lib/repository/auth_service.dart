import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));
  final Dio _dioPassword = Dio(BaseOptions(baseUrl: Constants.baseImageUrl));

  Future<Map<String, dynamic>> signup(String firstName,
      String lastName,
      String username,
      String password,
      String email,
      String phone,
      String countryCode,
      String dialCode,
      // String dob,
      ) async {
    try {
      print(email);
      final response = await _dio.post('/register', data: {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'country_code': countryCode,
        'dial_code': dialCode,
        'dob': '00-00-0000',
      });
      return response.data;
    } on DioException catch (e) {

      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
  Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    try {
      print(email);
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {

      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
  Future<Map<String, dynamic>> forgotPassword(
      String email,
      ) async {
    // try {
      print(email);
      final response = await _dioPassword.post('/api/send-password-reset-link', data: {
        'email': email,
      });
      print(response);
      return response.data;
    // } on DioException catch (e) {
    //
    //   throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    // }
  }
  Future<Map<String, dynamic>> socialLogin(
      String email,
      String providerId,
      String name,
      ) async {
    try {

      final response = await _dio.post('/social-login', data: {
        'provider_id': providerId,
        'name': name,
        'email': email,
      });
      return response.data;
    } on DioException catch (e) {

      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
}