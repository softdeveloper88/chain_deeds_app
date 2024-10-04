import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
   ProfileDetailsModel profileDetailsModel;
   Map<String,dynamic> response;

  ProfileSuccess(this.profileDetailsModel,this.response);

  @override
  List<Object> get props => [profileDetailsModel,response];
}
class ProfileUpdateSuccess extends ProfileState {
   Map<String,dynamic> response;

   ProfileUpdateSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}
