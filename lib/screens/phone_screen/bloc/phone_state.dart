import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class PhoneState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneInitial extends PhoneState {}

class PhoneLoading extends PhoneState {}

class PhoneSuccess extends PhoneState {
  Map<String,dynamic> response;

  PhoneSuccess(this.response);

  @override
  List<Object> get props => [response];
}


class PhoneFailure extends PhoneState {
  final String error;

  PhoneFailure(this.error);

  @override
  List<Object> get props => [error];
}
