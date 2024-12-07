import 'package:flutter/material.dart';

@immutable
sealed class LoginUserState {}

final class LoginUserInitialState extends LoginUserState {}

final class LoginUserLoadingState extends LoginUserState {}

final class LoginUserSuccessState extends LoginUserState {}

final class LoginUserFailureState extends LoginUserState {
  String errorMsg;

  LoginUserFailureState({required this.errorMsg});
}
