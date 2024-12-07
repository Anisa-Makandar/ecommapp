import 'package:flutter/material.dart';

@immutable
sealed class FetchCartEvent {}

class FetchMyCartEvent extends FetchCartEvent {}
