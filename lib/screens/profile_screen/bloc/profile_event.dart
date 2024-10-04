import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ProfileDetails extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileUpdateEvent extends ProfileEvent {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String dialCode;
  String countryCode;
  String dob;
  String gender;
  String country;
  String address;
  String profession;
  String placeOfWorship;

  ProfileUpdateEvent(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dialCode,
      this.countryCode,
      this.dob,
      this.gender,
      this.country,
      this.address,
      this.profession,
      this.placeOfWorship);
}
class PasswordUpdateEvent extends ProfileEvent {
  String oldPassword;
  String newPassword;
  String confirmPassword;

  PasswordUpdateEvent(
      this.oldPassword,
      this.newPassword,
      this.confirmPassword,);
}
class DeactivateAccountEvent extends ProfileEvent {

  DeactivateAccountEvent();
}
