import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../model/blog_model/blog_model.dart';

abstract class BlogState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogSuccess extends BlogState {
  Map<String,dynamic> response;
  BlogSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);

  @override
  List<Object> get props => [error];
}
