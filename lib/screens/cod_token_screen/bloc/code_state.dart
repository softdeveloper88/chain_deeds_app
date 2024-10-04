import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../model/blog_model/blog_model.dart';

abstract class CODState extends Equatable {
  @override
  List<Object> get props => [];
}

class CODInitial extends CODState {}

class CODLoading extends CODState {}

class CODSuccess extends CODState {

 Map<String,dynamic> response;
  CODSuccess(this.response);

  @override
  List<Object> get props => [response];
}


class CODFailure extends CODState {
  final String error;

  CODFailure(this.error);

  @override
  List<Object> get props => [error];
}
