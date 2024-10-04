import 'package:chain_deeds_app/model/campaign_model/campaign_model.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:equatable/equatable.dart';

import '../../../model/blog_model/blog_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {

  ProductSuccess();

  @override
  List<Object> get props => [];
}


class ProductFailure extends ProductState {
  final String error;

  ProductFailure(this.error);

  @override
  List<Object> get props => [error];
}
