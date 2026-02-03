import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  final TextInputType keyboardType;

  const BasicTextField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final borderColor = errorText == null ? Color(0xFF2A2A3A) : Color(0xFFF50057);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenWidth * 0.14,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFFA0A0B0), size: 22),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Color(0xFF505060)),
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 12),
            child: Text(
              errorText!,
              style: TextStyle(color: Color(0xFFF50057), fontSize: 12),
            ),
          ),
      ],
    );
  }
}