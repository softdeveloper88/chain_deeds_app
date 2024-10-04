import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:chain_deeds_app/repository/auth_service.dart';
import 'package:chain_deeds_app/repository/phone_service.dart';
import 'package:chain_deeds_app/repository/profile_service.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_event.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_event.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import 'phone_state.dart';


class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  final PhoneService _authService=PhoneService();
  PhoneBloc() : super(PhoneInitial()) {
    on<ChangePhoneVerifiedEvent>(_onChangePhoneNumber);
    on<AddPhoneVerifiedEvent>(_onAddPhoneNumber);
    on<CodeVerificationEvent>(_codeVerification);
  }
  CountryModel? countryModel;


  _onChangePhoneNumber(ChangePhoneVerifiedEvent event, Emitter<PhoneState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    try {
      var response = await _authService.changePhoneNumber(event.oldPhone,event.oldCountryCode,event.oldDialCode,event.phone, event.countryCode, event.dialCode);
       print("response $response");
      ProgressDialogUtils.hideProgressDialog();

      emit(PhoneSuccess(response));


    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(PhoneFailure("Verification failed: ${e.toString()}"));
    }

  }
  _onAddPhoneNumber(AddPhoneVerifiedEvent event, Emitter<PhoneState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    // try {
      var response = await _authService.addPhoneNumber(event.phone, event.countryCode, event.dialCode);

      ProgressDialogUtils.hideProgressDialog();
     print(response);
      emit(PhoneSuccess(response));

    // } catch (e) {
    //   print(e);
    //   ProgressDialogUtils.hideProgressDialog();
    //   emit(PhoneFailure("Verification failed: ${e.toString()}"));
    // }

  }
  _codeVerification(CodeVerificationEvent event, Emitter<PhoneState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    try {
      var response = await _authService.mobileNumberVerification(event.code);

      ProgressDialogUtils.hideProgressDialog();

      emit(PhoneSuccess(response));

    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(PhoneFailure("Verification failed: ${e.toString()}"));
    }

  }
}