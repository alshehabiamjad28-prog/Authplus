import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color labelColor;
  final Color backgroundColor;
  final Color borderColor;
  final double iconSize;
  final double buttonSize;
  final double labelFontSize;
  final Function() onTap;

  const SocialAuthButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.white,
    this.labelColor = const Color(0xFFA0A0B0),
    this.backgroundColor = const Color(0x10FFFFFF),
    this.borderColor = const Color(0x20FFFFFF),
    this.iconSize = 24,
    this.buttonSize = 56,
    this.labelFontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: labelFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}