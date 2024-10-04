import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class PhoneService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<Map<String, dynamic>> addPhoneNumber(
    String phone,
    String countryCode,
    String dialCode,
  ) async {
    try {
      final response = await _dio.post('/add-mobile-number', data: {
        'phone': phone,
        'country_code': countryCode,
        'dial_code': dialCode,
      },
          options: Options(headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          })
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }

  Future<Map<String, dynamic>> changePhoneNumber(
    String oldPhone,
    String oldCountryCode,
    String oldDialCode,
    String phone,
    String countryCode,
    String dialCode,
  ) async {
    try {
      final response = await _dio.post('/change-mobile-number',
          data: {
            'old_phone': oldPhone,
            'old_country_code': oldCountryCode,
            'old_dial_code': oldDialCode,
            'phone': phone,
            'country_code': countryCode,
            'dial_code': dialCode,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          }));
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }

  Future<Map<String, dynamic>> mobileNumberVerification(
    String code,
  ) async {
    try {
      final response = await _dio.post('/mobile-number-verification', data: {
        'verification_code': code,
      },
          options: Options(headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          })
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
}
