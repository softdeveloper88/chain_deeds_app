import 'package:chain_deeds_app/repository/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/campaign_model/campaign_model.dart';
import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final HomeService _homeService = HomeService();

  CampaignBloc() : super(CampaignInitial()) {
    on<CampaignDataEvent>(_getCampaignData);
    on<CampaignLikeDisLikeEvent>(_setLikeDislikeCampaign);
  }

  _getCampaignData(CampaignDataEvent event, Emitter<CampaignState> emit) async {
    emit(CampaignInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(CampaignLoading());
    try {
      CampaignModel response = await _homeService.getCampaignData();
      // ProgressDialogUtils.hideProgressDialog();
      if (response.status ?? false) {
        emit(CampaignSuccess(response));
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(CampaignFailure("Data Get failed: ${e.toString()}"));
    }
  }

  _setLikeDislikeCampaign(
      CampaignLikeDisLikeEvent event, Emitter<CampaignState> emit) async {
    // ProgressDialogUtils.showProgressDialog();
    // emit(CampaignLoading());
    try {
      Map<String, dynamic> response1 = await _homeService.likeDislikeCampaign(
          event.campaignId, event.action);
      // ProgressDialogUtils.hideProgressDialog();
      CampaignModel response = await _homeService.getCampaignData();
      // ProgressDialogUtils.hideProgressDialog();
      if (response.status ?? false) {
        emit(CampaignSuccess(response));
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(CampaignFailure("Data Get failed: ${e.toString()}"));
    }
  }
}
