import 'package:authproject/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import '../auth_validators.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/basic_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/phone_input_widget/otp_input_widget.dart';


class PhoneInputScreen extends StatefulWidget {
  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;
  bool _isLoading = false;

  void _sendOTP() {
    setState(() {
      _phoneError = AuthValidators.validatePhoneNumber(_phoneController.text);
    });

    if (_phoneError == null) {
      setState(() => _isLoading = true);
      print('📱 إرسال OTP إلى: ${_phoneController.text}');
      // هنا سترسل OTP عبر Supabase
      Future.delayed(Duration(seconds: 1), () {
        setState(() => _isLoading = false);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => OTPScreen(phoneNumber: "12345678")
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F1E), Color(0xFF1A1A2E)],
          ),
        ),
        child: Stack(
          children: [
            // الخلفية المضيئة (نفس ملف glowing_background.dart)
            // Positioned.fill(child: GlowingBackground()),

            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),

                    AuthHeaderWidget(
                      icon: Icons.phone_iphone_outlined,
                      title: 'رقم هاتفك',
                      subtitle: 'أدخل رقم هاتفك للمتابعة',
                    ),

                    SizedBox(height: screenHeight * 0.08),

                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(
                            0.1)),
                      ),
                      child: Column(
                        children: [
                          // حقل رقم الهاتف
                          BasicTextField(
                            icon: Icons.phone,
                            hintText: 'مثال: 05XXXXXXXX',
                            controller: _phoneController,
                            errorText: _phoneError,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              if (_phoneError != null) {
                                setState(() => _phoneError = null);
                              }
                            },
                          ),

                          SizedBox(height: screenWidth * 0.08),

                          GradientButton(
                            text: 'إرسال رمز التحقق',
                            onPressed: _sendOTP,
                            isLoading: _isLoading,
                          ),

                          SizedBox(height: screenWidth * 0.06),

                          Text(
                            'سيصلك رمز تحقق عبر SMS',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(height: screenWidth * 0.08),

                          AuthFooterLink(
                            prefixText: 'تراجع؟ ',
                            linkText: 'العودة',
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}