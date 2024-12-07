import 'package:ecommapp/data/models/product_data_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ProductState {}

final class ProductInitialState extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  ProductDataModel mData;
  ProductLoadedState({required this.mData});
}

final class ProductErrorState extends ProductState {
  String errorMsg;
  ProductErrorState({required this.errorMsg});
}
