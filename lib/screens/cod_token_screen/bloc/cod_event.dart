import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class CODEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CODDataEvent extends CODEvent {
  CODDataEvent();

  @override
  List<Object> get props => [];
}

class GetMemberDataEvent extends CODEvent {
  GetMemberDataEvent();

  @override
  List<Object> get props => [];
}

class CreateMemberEvent extends CODEvent {
  String id;
  String firstName;
  String lastName;
  String email;
  String relation;
  String dob;
  String profile;
  String phone;
  String countryCode;
  String dialCode;
  String notify;
  String status;
  bool isAdd;

  CreateMemberEvent(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.relation,
      this.dob,
      this.profile,
      this.phone,
      this.countryCode,
      this.dialCode,
      this.notify,
      this.status,
      this.isAdd);

  @override
  List<Object> get props => [];
}

class SendTokenEvent extends CODEvent {
  String token;
  String donationType;
  String interval;
  String member;
  String phone;
  String countryCode;
  String dialCode;

  SendTokenEvent(this.token, this.donationType, this.interval, this.member,
      this.phone, this.countryCode, this.dialCode);

  @override
  List<Object> get props => [];
}
