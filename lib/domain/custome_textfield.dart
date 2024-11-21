import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;

  CustomeTextfield(
      {required this.controller, required this.label, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFFDCDCDC),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFFDCDCDC),
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      ),
    );
  }
}
