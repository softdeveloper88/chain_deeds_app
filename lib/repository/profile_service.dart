import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));
  Future<ProfileDetailsModel> profileDetails() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/profile-details',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return ProfileDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<CountryModel> getCountries() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/countries',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return CountryModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String, dynamic>> updateProfile(
      String id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String dialCode,
      String countryCode,
      String dob,
      String gender,
      String country,
      String address,
      String profession,
      String placeOfWorship,
      ) async {
    // try {
      print(email);
      final response = await _dio.post('/profile-update', data: {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'dial_code': dialCode,
        'country_code': countryCode,
        'dob': dob,
        'gender': gender,
        'country': country,
        'address': address,
        'profession': profession,
        'place_of_worship': placeOfWorship,
      },
      options: Options(
      headers: {
      'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
      })
      );
      return response.data;

  }
  Future<Map<String, dynamic>> updatePassword(
      String oldPassword,
      String newPassword,
      String confirmPassword,
      ) async {
    // try {
      final response = await _dio.post('/change-password', data: {
        'old_password': oldPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
      options: Options(
      headers: {
      'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
      })
      );
      return response.data;

  }
  Future<Map<String, dynamic>> deactivateAccount() async {
    // try {
      final response = await _dio.post('/deactivate-account',
      options: Options(
      headers: {
      'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
      })
      );
      return response.data;

  }
  Future<Map<String, dynamic>> logoutAccount() async {
    // try {
      final response = await _dio.post('/logout',
      options: Options(
      headers: {
      'Authorization': 'Bearer ${Constants.userToken}', // Add Bearer token to headers
      })
      );
      return response.data;

  }
}