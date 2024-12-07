import 'package:flutter/foundation.dart';

@immutable
sealed class CreateOrderState {}

final class CreateOrderInitialState extends CreateOrderState {}

final class CreateOrderLoadingState extends CreateOrderState {}

final class CreateOrderSuccessState extends CreateOrderState {}

final class CreateOrderFailureState extends CreateOrderState {
  String errorMsg;
  CreateOrderFailureState({required this.errorMsg});
}
