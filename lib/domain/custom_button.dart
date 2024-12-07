import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  bool isLoading;
  String loadingMsg;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color color; // Use a single color
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;

  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.loadingMsg = "",
    this.width = 400,
    this.height = 50,
    this.color = const Color(0xFFFF660E), // Default to orange
    this.borderRadius = const BorderRadius.all(Radius.circular(25)),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color, // Use the single color here
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    loadingMsg,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            : Text(
                text,
                style: textStyle,
              ),
      ),
    );
  }
}
