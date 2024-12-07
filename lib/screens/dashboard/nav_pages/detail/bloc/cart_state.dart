import 'package:flutter/material.dart';

@immutable
sealed class CartState {}

final class CartInitialState extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {}

final class CartFailureState extends CartState {
  String errorMsg;
  CartFailureState({required this.errorMsg});
}
