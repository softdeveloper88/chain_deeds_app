import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/model/product_model/product_details_model.dart';
import 'package:chain_deeds_app/model/product_model/product_model.dart';
import 'package:chain_deeds_app/screens/shop_screen/product_details_screen.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<ProductModel> getProductData() async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/products',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
  Future<ProductDetailsModel> getProductDetails(productId) async {
    try {
      // Adding authorization token in headers
      final response = await _dio.post(
        '/product-details',
        data: FormData.fromMap({
          'id':productId
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
            // Add Bearer token to headers
          },
        ),
      );

      // Parse the response and return the ProfileDetailsModel
      return ProductDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      // Improved error handling, capturing status code or message if available
      throw Exception(e.response?.data['message'] ?? 'Unknown error occurred');
    } catch (e) {
      // Catch any other errors that might occur
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
