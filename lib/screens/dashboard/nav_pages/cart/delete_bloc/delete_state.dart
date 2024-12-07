import 'package:flutter/foundation.dart';

@immutable
sealed class DeleteState {}

final class DeleteOrderInitialState extends DeleteState {}

final class DeleteOrderLoadingState extends DeleteState {}

final class DeleteOrderSuccessState extends DeleteState {}

final class DeleteOrderFailureState extends DeleteState {
  String errorMsg;
  DeleteOrderFailureState({required this.errorMsg});
}
