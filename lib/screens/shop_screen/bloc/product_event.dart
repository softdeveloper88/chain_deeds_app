import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductDataEvent extends ProductEvent {

  ProductDataEvent();
  @override
  List<Object> get props => [];
}
class ProductDetailsEvent extends ProductEvent {
  int productId;
  ProductDetailsEvent(this.productId);
  @override
  List<Object> get props => [productId];
}

