import 'package:ecommapp/data/models/viewcart_data_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class FetchCartState {}

final class FetchCartInitalState extends FetchCartState {}

final class FetchCartLoadingState extends FetchCartState {}

final class FetchCartLoadedState extends FetchCartState {
  CartDataModel mData;
  FetchCartLoadedState({required this.mData});
}

final class FetchCartErrorState extends FetchCartState {
  String errorMsg;
  FetchCartErrorState({required this.errorMsg});
}
