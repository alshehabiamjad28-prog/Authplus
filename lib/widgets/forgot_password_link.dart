import 'package:flutter/material.dart';

class ForgotPasswordLink extends StatelessWidget {
  final Function() onTap;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const ForgotPasswordLink({
    Key? key,
    required this.onTap,
    this.textColor = const Color(0xFF6C63FF),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          'هل نسيت كلمة المرور؟',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
            decorationThickness: 1.5,
          ),
        ),
      ),
    );
  }
}