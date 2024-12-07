import 'package:flutter/material.dart';

@immutable
sealed class ProductEvent {}

class GeetAllProductEvent extends ProductEvent {}
