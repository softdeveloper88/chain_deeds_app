import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  @override
  List<Object> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberSuccess extends MemberState {
  var response;

  MemberSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class MemberFailure extends MemberState {
  final String error;

  MemberFailure(this.error);

  @override
  List<Object> get props => [error];
}
