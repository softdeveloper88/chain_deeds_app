import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeModel response;

  HomeSuccess(this.response);

  @override
  List<Object> get props => [response];
}


class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);

  @override
  List<Object> get props => [error];
}
