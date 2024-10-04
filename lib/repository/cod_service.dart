import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/cod_model/cod_token_model.dart';
import 'package:chain_deeds_app/model/cod_model/get_member_model.dart';
import 'package:chain_deeds_app/model/product_model/product_model.dart';
import 'package:dio/dio.dart';

class CODService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<CodTokenModel> getCODData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/mdtokens',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return CodTokenModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<GetMemberModel> getMemberData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/family-and-members',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return GetMemberModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> createUpdateMember(
      String id,
      String firstName,
      String lastName,
      String email,
      String relation,
      String dob,
      String profile, // The file path for the profile image
      String phone,
      String countryCode,
      String dialCode,
      String notify,
      String status,
      bool isAdd,

      ) async {
    try {
      if(isAdd) {
        FormData formData = FormData.fromMap({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'relation': relation,
          'dob': dob,
          'phone': phone,
          'country_code': countryCode,
          'dial_code': dialCode,
          'notify': notify,
          'status': status,
          'profile': profile !=""?await MultipartFile.fromFile(profile, filename: profile):"",
          // Profile image file
        });
        final response = await _dio.post(
          '/create-family-and-friend',
          data: formData, // Pass the FormData object
          options: Options(
            headers: {
              'Authorization': 'Bearer ${Constants.userToken}',
            },
            contentType: 'multipart/form-data', // Ensure content type is multipart
          ),
        );
        // Parse the response and return the ProfileDetailsModel
        return response.data;
      }else {
        FormData formData = FormData.fromMap({
          'id': id,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'relation': relation,
          'dob': dob,
          'phone': phone,
          'country_code': countryCode,
          'dial_code': dialCode,
          'notify': notify,
          'status': status,
          'profile': profile !=""?await MultipartFile.fromFile(profile, filename: profile):"",
          // Profile image file
        });
        final response = await _dio.post(
          '/update-family-and-members',
          data: formData, // Pass the FormData object
          options: Options(
            headers: {
              'Authorization': 'Bearer ${Constants.userToken}',
            },
            contentType: 'multipart/form-data', // Ensure content type is multipart
          ),
        );

        // Parse the response and return the ProfileDetailsModel
        return response.data;
      }
      // Adding authorization token in headers

    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
Future<Map<String, dynamic>> sendToken(
      String token,
      String donationType,
      String interval,
      String member,
      String phone,
      String countryCode,
      String dialCode,

      ) async {
    try {

        FormData formData = FormData.fromMap({
          'tokens': token,
          'donation_type': donationType,
          'interval': interval,
          'members': member,
          'phone': phone,
          'country_code': countryCode,
          'dial_code': dialCode,
        });
        final response = await _dio.post(
          '/send-tokens-submit',
          data: formData, // Pass the FormData object
          options: Options(
            headers: {
              'Authorization': 'Bearer ${Constants.userToken}',
            },
          ),
        );
        // Parse the response and return the ProfileDetailsModel
        return response.data;

      // Adding authorization token in headers

    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }}
