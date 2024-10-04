import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:dio/dio.dart';

class HomeService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<HomeModel> getHomeData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/home',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return HomeModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<CampaignModel> getCampaignData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/campaigns',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return CampaignModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String,dynamic>> likeDislikeCampaign(int campaignId,String action) async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        action=="like" ?'/like-a-campaign':'unlike-a-campaign',
        data: {
          'campaign_id':campaignId
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );
     print(response.data);
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
