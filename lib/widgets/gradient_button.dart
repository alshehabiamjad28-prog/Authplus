import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final List<Color> gradientColors;
  final double borderRadius;
  final double shadowBlur;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 56,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.textColor = Colors.white,
    this.gradientColors = const [
      Color(0xFF6C63FF),
      Color(0xFF8A2BE2),
    ],
    this.borderRadius = 16,
    this.shadowBlur = 20,
    this.padding,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.4),
            blurRadius: shadowBlur,
            spreadRadius: 0,
            offset: Offset(0, screenWidth * 0.02),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            child: Center(
              child: isLoading
                  ? SizedBox(
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
              )
                  : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}