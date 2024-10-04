import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class CampaignState extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignSuccess extends CampaignState {
  CampaignModel response;

  CampaignSuccess(this.response);

  @override
  List<Object> get props => [response];
}


class CampaignFailure extends CampaignState {
  final String error;

  CampaignFailure(this.error);

  @override
  List<Object> get props => [error];
}
