import 'package:flutter/material.dart';

@immutable
sealed class RegisterUserEvent {}

class CreateUserEvent extends RegisterUserEvent {
  String name;
  String email;
  String mobNo;
  String pass;

  CreateUserEvent(
      {required this.name,
      required this.email,
      required this.mobNo,
      required this.pass});
}
