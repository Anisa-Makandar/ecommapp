import 'package:flutter/material.dart';

@immutable
sealed class LoginUserEvent {}

class AuthenticateUser extends LoginUserEvent {
  String email;
  String pass;

  AuthenticateUser({required this.email, required this.pass});
}
