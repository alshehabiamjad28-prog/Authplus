import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final Color lineColor;
  final Color textColor;
  final double lineThickness;
  final double textFontSize;
  final FontWeight textFontWeight;
  final EdgeInsetsGeometry padding;

  const DividerWithText({
    Key? key,
    required this.text,
    this.lineColor = const Color(0x40FFFFFF),
    this.textColor = const Color(0xFF808090),
    this.lineThickness = 1,
    this.textFontSize = 13,
    this.textFontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: lineThickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  lineColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textFontSize,
              fontWeight: textFontWeight,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: lineThickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  lineColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}