import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/repository/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<SignUpSubmitted>(_onSignUP);
    on<LoginSubmitted>(_onLogin);
    on<SocialLoginSubmitted>(_onSocialLogin);
    on<ForgotSubmitted>(_onForgotPassword);
  }

  _onSignUP(SignUpSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(AuthLoading());
    try {
      Map<String, dynamic> response = await _authService.signup(
          event.firstName,
          event.lastName,
          event.username,
          event.password,
          event.email,
          event.phone,
          event.countryCode,
          event.dialCode);
      ProgressDialogUtils.hideProgressDialog();
      print(response['status']);
      if (response['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_token', '');
        await prefs.setString('access_token', response['data']['access_token'] ?? '');
        await prefs.setInt('userId', response['data']['user']['id'] ?? '');
        await prefs.setString('name',
            '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}');
        await prefs.setString('email', response['data']['user']['email'] ?? '');
        await prefs.setString('phone', response['data']['user']['phone'] ?? '');
        // if (response['data']['access_token'] ?? '' != '') {
        Constants.userToken = response['data']['access_token'] ?? '';
        Constants.deviceToken = response['data']['access_token'] ?? '';
        Constants.logInUserId = response['data']['user']['id'].toString();
        Constants.name =
            '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}';
        Constants.email = response['data']['user']['email'] ?? '';
        // }
      }
      emit(AuthSuccess(response, 'signup'));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(AuthFailure("Signup failed: ${e.toString()}"));
    }
  }

  _onLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(AuthLoading());
    try {
      Map<String, dynamic> response =
          await _authService.login(event.email, event.password);
      ProgressDialogUtils.hideProgressDialog();
      print(response['status']);
      if (response['status']) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_token', '');
        await prefs.setString(
            'access_token', response['data']['access_token'] ?? '');
        await prefs.setInt('userId', response['data']['user']['id'] ?? '');
        await prefs.setString('name',
            '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}');
        await prefs.setString('email', response['data']['user']['email'] ?? '');
        await prefs.setString('phone', response['data']['user']['phone'] ?? '');
        // if (response['data']['access_token'] ?? '' != '') {
        Constants.userToken = response['data']['access_token'] ?? '';
        Constants.deviceToken = response['data']['access_token'] ?? '';
        Constants.logInUserId = response['data']['user']['id'].toString();
        Constants.name =
            '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}';
        Constants.email = response['data']['user']['email'] ?? '';
        // }
      }
      emit(AuthSuccess(response, 'login'));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(AuthFailure("Signup failed: ${e.toString()}"));
    }
  }

  _onForgotPassword(ForgotSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(AuthLoading());
    try {
      Map<String, dynamic> response = await _authService.forgotPassword(event.email);
      print(response);
      ProgressDialogUtils.hideProgressDialog();

      emit(AuthSuccess(response, 'forgot'));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(AuthFailure("Signup failed: ${e.toString()}"));
    }
  }

  _onSocialLogin(SocialLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    ProgressDialogUtils.showProgressDialog();
    emit(AuthLoading());
    try {
      Map<String, dynamic> response = await _authService.socialLogin(
          event.email, event.providerId, event.name);
      ProgressDialogUtils.hideProgressDialog();
      print(response['status']);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response['status']) {
        if(response['data']['user']['phone_verified_at'] != null){
        await prefs.setString('device_token', '');
        await prefs.setString('access_token', response['data']['access_token'] ?? '');
        await prefs.setInt('userId', response['data']['user']['id'] ?? '');
        await prefs.setString('name',
            '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}');
        await prefs.setString('email', response['data']['user']['email'] ?? '');
        await prefs.setString('phone', response['data']['user']['phone'] ?? '');
        // if (response['data']['access_token'] ?? '' != '') {
        Constants.userToken = response['data']['access_token'] ?? '';
        Constants.deviceToken = response['data']['access_token'] ?? '';
        Constants.logInUserId = response['data']['user']['id'].toString();
        Constants.name = '${response['data']['user']['first_name'] ?? ''} ${response['data']['user']['first_name'] ?? ''}';
        Constants.email = response['data']['user']['email'] ?? '';
        }else{
          Constants.userToken = response['data']['access_token'] ?? '';
        }
      }
      emit(AuthSuccess(response, 'social_login'));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(AuthFailure("Signup failed: ${e.toString()}"));
    }
  }
}
