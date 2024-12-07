import 'package:flutter/material.dart';

@immutable
sealed class DeleteEvent {}

class DeleteOrderEvent extends DeleteEvent {
  int cartId;
  DeleteOrderEvent({required this.cartId});
}
