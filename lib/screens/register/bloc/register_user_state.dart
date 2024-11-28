import 'package:flutter/material.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitialState extends RegisterUserState {}

final class RegisterUserLoadingState extends RegisterUserState {}

final class RegisterUserSuccessState extends RegisterUserState {}

final class RegisterUserFailureState extends RegisterUserState {
  String errorMsg;
  RegisterUserFailureState({required this.errorMsg});
}
