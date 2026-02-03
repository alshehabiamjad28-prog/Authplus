import 'package:flutter/material.dart';

class OTPInputWidget extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onCompleted;

  const OTPInputWidget({
    Key? key,
    required this.onChanged,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _OTPInputWidgetState createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<String> _codes = List.filled(6, '');

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty) {
      _codes[index] = value;
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      _codes[index] = '';
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    // تجميع الكود
    String fullCode = _codes.join();

    // إرسال التحديث
    widget.onChanged(fullCode);

    // إذا اكتمل
    if (fullCode.length == 6) {
      widget.onCompleted(fullCode);
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.12;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _codes[index].isNotEmpty
                  ? Color(0xFF6C63FF)
                  : Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: boxSize * 0.4,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) => _onTextChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}