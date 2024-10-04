import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageMemberEvent extends MemberEvent {
  String message;
  String audio;
  String document;
  SendMessageMemberEvent(this.message,this.audio,this.document);
  @override
  List<Object> get props => [message,audio,document];
}
class AddCampaignIdea extends MemberEvent {
  String countryId;
  String title;
  String description;
  AddCampaignIdea(this.countryId,this.title,this.description);
  @override
  List<Object> get props => [countryId,title,description];
}
class MembersWallMessageReactionEvent extends MemberEvent {
  String messageId;
  String action;
  MembersWallMessageReactionEvent(this.messageId,this.action);
  @override
  List<Object> get props => [messageId,action];
}
class GetCountryEvent extends MemberEvent {

  GetCountryEvent();
  @override
  List<Object> get props => [];
}
class MemberDataEvent extends MemberEvent {
  int offset;
  MemberDataEvent(this.offset);
  @override
  List<Object> get props => [offset];
}
class CheckIfNeedMoreDataEvent extends MemberEvent {
  final int offset;
  CheckIfNeedMoreDataEvent({required this.offset});
  @override
  List<Object> get props => [offset];
}


