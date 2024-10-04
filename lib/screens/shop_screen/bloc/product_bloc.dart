import 'package:chain_deeds_app/model/product_model/product_details_model.dart';
import 'package:chain_deeds_app/model/product_model/product_model.dart';
import 'package:chain_deeds_app/repository/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _serviceApi = ProductService();
  ProductModel? productsModel;
  ProductDetailsModel? productDetailsModel;

  ProductBloc() : super(ProductInitial()) {
    on<ProductDataEvent>(_getProductData);
    on<ProductDetailsEvent>(_getProductDetails);
  }

  _getProductData(ProductDataEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(ProductLoading());
    try {
      productsModel = await _serviceApi.getProductData();
      // ProgressDialogUtils.hideProgressDialog();

      if (productsModel?.status ?? false) {
        emit(ProductSuccess());
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(ProductFailure("Data Get failed: ${e.toString()}"));
    }
  }

  _getProductDetails(
      ProductDetailsEvent event, Emitter<ProductState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    emit(ProductLoading());
    try {
      productDetailsModel =
          await _serviceApi.getProductDetails(event.productId);
      print(productDetailsModel!.toJson());
      emit(ProductSuccess());
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(ProductFailure("Data Get failed: ${e.toString()}"));
    }
  }
}
