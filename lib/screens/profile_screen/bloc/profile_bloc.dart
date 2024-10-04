import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:chain_deeds_app/repository/profile_service.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_event.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService _authService = ProfileService();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileDetails>(getProfileDetails);
    on<ProfileUpdateEvent>(updateProfileDetails);
    on<PasswordUpdateEvent>(updatePassword);
  }

  CountryModel? countryModel;

  getProfileDetails(ProfileDetails event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(ProfileLoading());
    try {
      ProfileDetailsModel response = await _authService.profileDetails();
      countryModel = await _authService.getCountries();
      // ProgressDialogUtils.hideProgressDialog();
      if (response.status ?? false) {
        emit(ProfileSuccess(response, {}));
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(ProfileFailure("Signup failed: ${e.toString()}"));
    }
  }

  updateProfileDetails(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    try {
      var response = await _authService.updateProfile(
          event.id,
          event.firstName,
          event.lastName,
          event.email,
          event.phone,
          event.dialCode,
          event.countryCode,
          event.dob,
          event.gender,
          event.country,
          event.address,
          event.profession,
          event.placeOfWorship);
      ProfileDetailsModel profileDetailsModel =
          await _authService.profileDetails();

      ProgressDialogUtils.hideProgressDialog();

      emit(ProfileSuccess(profileDetailsModel, response));
    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(ProfileFailure("Signup failed: ${e.toString()}"));
    }
  }

  updatePassword(PasswordUpdateEvent event, Emitter<ProfileState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    try {
      Map<String, dynamic> response = await _authService.updatePassword(
          event.oldPassword, event.newPassword, event.confirmPassword);
      ProfileDetailsModel profileDetailsModel =
          await _authService.profileDetails();
      ProgressDialogUtils.hideProgressDialog();

      emit(ProfileSuccess(profileDetailsModel, response));
    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(ProfileFailure("Signup failed: ${e.toString()}"));
    }
  }

  deactivateAccount(
      DeactivateAccountEvent event, Emitter<ProfileState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    // emit(ProfileLoading());
    try {
      Map<String, dynamic> response = await _authService.deactivateAccount();
      ProgressDialogUtils.hideProgressDialog();
      emit(ProfileSuccess(ProfileDetailsModel(), response));
    } catch (e) {
      print(e);
      ProgressDialogUtils.hideProgressDialog();
      emit(ProfileFailure("Signup failed: ${e.toString()}"));
    }
  }
}
