import 'package:flutter/material.dart';

class GlowingBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // مربع أزرق
        Positioned(
          top: screenHeight * 0.1,
          right: screenWidth * 0.1,
          child: _buildGlowingSquare(
            size: screenWidth * 0.02,
            color: Color(0xFF6C63FF),
          ),
        ),

        // مربع وردي
        Positioned(
          top: screenHeight * 0.3,
          left: screenWidth * 0.15,
          child: _buildGlowingSquare(
            size: screenWidth * 0.015,
            color: Color(0xFFF50057),
          ),
        ),

        // مربع أخضر
        Positioned(
          bottom: screenHeight * 0.2,
          right: screenWidth * 0.2,
          child: _buildGlowingSquare(
            size: screenWidth * 0.025,
            color: Color(0xFF00D2AA),
          ),
        ),

        // مربع أصفر
        Positioned(
          bottom: screenHeight * 0.4,
          left: screenWidth * 0.1,
          child: _buildGlowingSquare(
            size: screenWidth * 0.01,
            color: Color(0xFFFFD700),
          ),
        ),

        // مربع بنفسجي
        Positioned(
          top: screenHeight * 0.5,
          right: screenWidth * 0.3,
          child: _buildGlowingSquare(
            size: screenWidth * 0.018,
            color: Color(0xFF8A2BE2),
          ),
        ),
      ],
    );
  }

  Widget _buildGlowingSquare({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: size * 2,
            spreadRadius: size * 0.5,
          ),
        ],
      ),
    );
  }
}