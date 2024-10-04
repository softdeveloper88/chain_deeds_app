import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignDataEvent extends CampaignEvent {

  CampaignDataEvent();
  @override
  List<Object> get props => [];
}
class CampaignLikeDisLikeEvent extends CampaignEvent {
  int campaignId;
  String action;
  CampaignLikeDisLikeEvent(this.campaignId,this.action);
  @override
  List<Object> get props => [campaignId,action];
}

