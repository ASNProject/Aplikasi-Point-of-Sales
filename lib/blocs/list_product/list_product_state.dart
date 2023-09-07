import 'package:cash_whiz/core/models/list_product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListProductState extends Equatable {}

class ListProductLoadingState extends ListProductState {
  @override
  List<Object?> get props => [];
}

class ListProductLoadedState extends ListProductState {
  final List<ListProductModel> listProducts;
  ListProductLoadedState(this.listProducts);
  @override
  List<Object?> get props => [listProducts];
}

class ListProductErrorState extends ListProductState {
  final String error;
  ListProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
