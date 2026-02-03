import 'package:flutter/material.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/gradient_button.dart';
import '../widgets/phone_input_widget/otp_input_widget.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _otpCode = '';
  bool _isLoading = false;

  void _handleVerify() {
    setState(() => _isLoading = true);

    print('OTP Code: $_otpCode');
    print('Phone: ${widget.phoneNumber}');

    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1E),
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.07,
                    vertical: screenHeight * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      AuthHeaderWidget(
                        icon: Icons.lock_outline_rounded,
                        title: 'رمز التحقق',
                        subtitle: 'أدخل الرمز المرسل إلى ${widget.phoneNumber}',
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.06),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 40,
                              spreadRadius: -10,
                              offset: Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            OTPInputWidget(
                              onChanged: (code) {
                                setState(() {
                                  _otpCode = code;
                                });
                              },
                              onCompleted: (code) {
                                setState(() {
                                  _otpCode = code;
                                });
                                // التحقق التلقائي إذا اكتمل
                                if (code.length == 6) {
                                  _handleVerify();
                                }
                              },
                            ),
                            SizedBox(height: screenWidth * 0.08),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'لم يصلك الرمز؟ ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('إعادة إرسال الكود');
                                    // أضف كود إعادة الإرسال هنا
                                  },
                                  child: Text(
                                    'إعادة الإرسال',
                                    style: TextStyle(
                                      color: Colors.white, // أبيض
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            GradientButton(

                              text: 'تحقق',
                              onPressed: () {

                              },
                              isLoading: _isLoading,
                              height: screenWidth * 0.14,
                            ),

                            SizedBox(height: screenWidth * 0.06),

                            Text(
                              'أدخل الرمز المكون من 6 أرقام',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),

                            SizedBox(height: screenWidth * 0.06),

                            Center(
                              child: AuthFooterLink(
                                prefixText: 'تغيير الرقم؟ ',
                                linkText: 'رجوع',
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}