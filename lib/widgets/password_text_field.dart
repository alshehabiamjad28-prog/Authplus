import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final borderColor = widget.errorText == null ? Color(0xFF2A2A3A) : Color(0xFFF50057);

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
              Icon(Icons.lock, color: Color(0xFFA0A0B0), size: 22),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    hintStyle: TextStyle(color: Color(0xFF505060)),
                    border: InputBorder.none,
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFFA0A0B0),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 12),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Color(0xFFF50057), fontSize: 12),
            ),
          ),
      ],
    );
  }
}