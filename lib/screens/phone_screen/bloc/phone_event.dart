import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class PhoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ProfileDetails extends PhoneEvent {
  @override
  List<Object> get props => [];
}

class ChangePhoneVerifiedEvent extends PhoneEvent {
  String oldPhone;
  String oldCountryCode;
  String oldDialCode;
  String phone;
  String countryCode;
  String dialCode;

  ChangePhoneVerifiedEvent(
      this.oldPhone,
      this.oldCountryCode,
      this.oldDialCode,
      this.phone,
      this.countryCode,
      this.dialCode,
    );
}
class AddPhoneVerifiedEvent extends PhoneEvent {
  String phone;
  String countryCode;
  String dialCode;

  AddPhoneVerifiedEvent(

      this.phone,
      this.countryCode,
      this.dialCode,
    );
}
class CodeVerificationEvent extends PhoneEvent {
  String code;
  CodeVerificationEvent(this.code);
}
