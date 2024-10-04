import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/member_wall_model/member_message_model.dart';
import 'package:chain_deeds_app/model/product_model/product_model.dart';
import 'package:dio/dio.dart';

class MemberService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<MemberMessageModel> getMemberData(int offset) async {
    try {
      print(offset);
      // Adding authorization token in headers
      final response = await _dio.post(
        '/members-wall-messages',
        data: FormData.fromMap({
          'offset':offset
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return MemberMessageModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String,dynamic>> sendMessageMemberWall(
      String message,
      String audio,
      String document,
      ) async {
    try {
      // Adding authorization token in headers

      final response = await _dio.post(
        '/members-wall-send-message',
        data:  FormData.fromMap({
          'message':message,
          'audio': audio !=""?await MultipartFile.fromFile(audio, filename: audio):"",
          'document':document !=""?await MultipartFile.fromFile(document, filename: document):"",

        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
          contentType: 'multipart/form-data', // Ensure content type is multipart

        ),
      );
      print(response.data.toString());

      // Parse the response and return the ProfileDetailsModel
      return response.data;
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String,dynamic>> membersWallMessageReaction(
      String messageId,
      String action,
      ) async {
    try {
      // Adding authorization token in headers

      final response = await _dio.post(
        '/members-wall-message-reaction',
        data:  FormData.fromMap({
          'message_id':messageId,
          'action_type': action ,

        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },

        ),
      );
      print(response.data.toString());

      // Parse the response and return the ProfileDetailsModel
      return response.data;
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String,dynamic>> addCampaignIdea(
      String countryId,
      String title,
      String description,
      ) async {
    try {
      // Adding authorization token in headers

      final response = await _dio.post(
        '/members-wall-send-message',
        data:  FormData.fromMap({
          'country_id':countryId,
          'description': description,
          'campaign_for':title

        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
          contentType: 'multipart/form-data', // Ensure content type is multipart

        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return response.data;
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
