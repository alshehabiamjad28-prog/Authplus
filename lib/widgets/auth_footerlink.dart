import 'package:flutter/material.dart';

class AuthFooterLink extends StatelessWidget {
  final String prefixText;
  final String linkText;
  final Function() onTap;
  final Color prefixColor;
  final Color linkColor;
  final double fontSize;
  final FontWeight prefixFontWeight;
  final FontWeight linkFontWeight;
  final bool showUnderline;

  const AuthFooterLink({
    Key? key,
    required this.prefixText,
    required this.linkText,
    required this.onTap,
    this.prefixColor = const Color(0xFFA0A0B0),
    this.linkColor = const Color(0xFF6C63FF),
    this.fontSize = 14,
    this.prefixFontWeight = FontWeight.w400,
    this.linkFontWeight = FontWeight.w700,
    this.showUnderline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: prefixText,
              style: TextStyle(
                color: prefixColor,
                fontSize: fontSize,
                fontWeight: prefixFontWeight,
              ),
            ),
            TextSpan(
              text: linkText,
              style: TextStyle(
                color: linkColor,
                fontSize: fontSize,
                fontWeight: linkFontWeight,
                decoration: showUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationThickness: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}