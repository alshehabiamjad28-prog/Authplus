import 'package:flutter/material.dart';
import '../auth_validators.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/basic_text_field.dart';
import '../widgets/gradient_button.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;
  bool _isLoading = false;

  void _handleSendResetLink() {
    setState(() {
      _emailError = AuthValidators.validateEmail(_emailController.text);
    });

    if (_emailError == null) {
      setState(() => _isLoading = true);
      print('📧 إرسال رابط إعادة التعيين إلى: ${_emailController.text}');

      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        print('✅ تم إرسال الرابط بنجاح!');
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                        icon: Icons.lock_reset_outlined,
                        title: 'نسيت كلمة المرور',
                        subtitle: 'أدخل بريدك الإلكتروني لإرسال رابط التعيين',
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
                            BasicTextField(
                              icon: Icons.email_outlined,
                              hintText: 'البريد الإلكتروني',
                              controller: _emailController,
                              errorText: _emailError,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                if (_emailError != null) {
                                  setState(() => _emailError = null);
                                }
                              },
                            ),

                            SizedBox(height: screenWidth * 0.08),



                            GradientButton(
                              text: 'إرسال رابط التعيين',
                              onPressed: _handleSendResetLink,
                              isLoading: _isLoading,
                              height: screenWidth * 0.14,
                            ),

                            SizedBox(height: screenWidth * 0.06),
                            Align(
                              alignment: Alignment.centerLeft,


                              child:  Row(
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
                              ),),

                            SizedBox(height: screenWidth * 0.06),

                            Text(
                              'سيصلك رابط لإعادة تعيين كلمة المرور عبر البريد الإلكتروني',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            Center(
                              child: AuthFooterLink(
                                prefixText: 'تذكرت كلمة المرور؟ ',
                                linkText: 'العودة لتسجيل الدخول',
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