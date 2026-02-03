import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double iconSize;
  final Color iconColor;
  final Color titleColor;
  final Color subtitleColor;

  const AuthHeaderWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 32,
    this.iconColor = const Color(0xFF6C63FF),
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0xFFA0A0B0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.13,
          height: screenWidth * 0.13,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  fontFamily: 'Tajawal',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}