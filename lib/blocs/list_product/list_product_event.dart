import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListProductEvent extends Equatable {
  const ListProductEvent();
}

class LoadListProductEvent extends ListProductEvent {
  @override
  List<Object?> get props => [];
}
