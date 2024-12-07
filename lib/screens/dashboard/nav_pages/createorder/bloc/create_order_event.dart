import 'package:flutter/material.dart';

@immutable
sealed class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  bool status;
  String message;
  CreateOrderEvent({required this.message, required this.status});
}
