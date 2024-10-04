import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/repository/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _homeService = HomeService();

  HomeBloc() : super(HomeInitial()) {
    on<HomeDataEvent>(_getHomeData);
  }

  _getHomeData(HomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(HomeLoading());
    try {
      HomeModel response = await _homeService.getHomeData();
      // ProgressDialogUtils.hideProgressDialog();
      if (response.status ?? false) {
        emit(HomeSuccess(response));
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(HomeFailure("Data Get failed: ${e.toString()}"));
    }
  }
}
