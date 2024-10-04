import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class ProfileDetails extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeDataEvent extends HomeEvent {

  HomeDataEvent(
    );
}

