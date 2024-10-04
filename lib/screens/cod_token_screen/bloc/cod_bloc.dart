import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/cod_model/cod_token_model.dart';
import 'package:chain_deeds_app/model/cod_model/get_member_model.dart';
import 'package:chain_deeds_app/repository/cod_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cod_event.dart';
import 'code_state.dart';

class CODBloc extends Bloc<CODEvent, CODState> {
  final CODService _serviceApi = CODService();
 GetMemberModel? getMemberModel;
  CodTokenModel? codTokenModel;

  CODBloc() : super(CODInitial()) {
    on<CODDataEvent>(_getCODData);
    on<CreateMemberEvent>(_createMember);
    on<GetMemberDataEvent>(_getMemberData);
    on<SendTokenEvent>(_sendToken);
  }

  _getCODData(CODDataEvent event, Emitter<CODState> emit) async {
    emit(CODInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(CODLoading());
    try {
      codTokenModel = await _serviceApi.getCODData();
      // ProgressDialogUtils.hideProgressDialog();
        emit(CODSuccess({}));

    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(CODFailure("Data Get failed: ${e.toString()}"));
    }
  }
  _getMemberData(GetMemberDataEvent event, Emitter<CODState> emit) async {
    emit(CODInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(CODLoading());
    try {
       getMemberModel = await _serviceApi.getMemberData();
      // ProgressDialogUtils.hideProgressDialog();
        emit(CODSuccess({}));

    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(CODFailure("Data Get failed: ${e.toString()}"));
    }
  }
 _createMember(CreateMemberEvent event, Emitter<CODState> emit) async {
    emit(CODInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(CODLoading());
    try {
      Map<String, dynamic>  response = await _serviceApi.createUpdateMember(
            event.id,
            event.firstName,
            event.lastName,
            event.email,
            event.relation,
            event.dob,
            event.profile,
            event.phone,
            event.countryCode,
            event.dialCode,
            event.notify,
            event.status,event.isAdd);

       ProgressDialogUtils.hideProgressDialog();
        emit(CODSuccess(response));
    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(CODFailure("Data Get failed: ${e.toString()}"));
    }
  }
  _sendToken(SendTokenEvent event, Emitter<CODState> emit) async {
    emit(CODInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(CODLoading());
    try {
      Map<String, dynamic>  response = await _serviceApi.sendToken(event.token, event.donationType, event.interval, event.member, event.phone, event.countryCode, event.dialCode);

       ProgressDialogUtils.hideProgressDialog();
        emit(CODSuccess(response));
    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(CODFailure("Data Get failed: ${e.toString()}"));
    }
  }

// _setLikeDislikeCOD(
//     CODLikeDisLikeEvent event, Emitter<CODState> emit) async {
//   // ProgressDialogUtils.showProgressDialog();
//   // emit(CODLoading());
//   try {
//     Map<String, dynamic> response1 = await _homeService.likeDislikeCOD(
//         event.campaignId, event.action);
//     // ProgressDialogUtils.hideProgressDialog();
//     CODModel response = await _homeService.getCODData();
//     // ProgressDialogUtils.hideProgressDialog();
//     if (response.status ?? false) {
//       emit(CODSuccess(response));
//     }
//   } catch (e) {
//     // ProgressDialogUtils.hideProgressDialog();
//     emit(CODFailure("Data Get failed: ${e.toString()}"));
//   }
// }
}
