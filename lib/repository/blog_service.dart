import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/blog_model/blog_category_model.dart';
import 'package:chain_deeds_app/model/blog_model/blog_model.dart';
import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:dio/dio.dart';

class BlogService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<BlogModel> getBlogData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/blogs',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return BlogModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<BlogCategoryModel> getCategoryBlogData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/blog-categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );
print(response.data.toString());
      // Parse the response and return the ProfileDetailsModel
      return BlogCategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<Map<String,dynamic>> addBlogData(
     String categoryId,
     String thumbnail,
     String title,
     String sub_title,
     String description,
      ) async {
    try {
      // Adding authorization token in headers

      final response = await _dio.post(
        '/blogs/store',
        data:  FormData.fromMap({
          'category_id':int.parse(categoryId),
          'thumbnail': thumbnail !=""?await MultipartFile.fromFile(thumbnail, filename: thumbnail):"",
          'title':title,
          'sub_title':sub_title,
          'description':description

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