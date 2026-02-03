import 'package:authproject/screens/forgot_password_screen.dart';
import 'package:authproject/screens/phone_input_screen.dart';
import 'package:authproject/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../auth_validators.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/basic_text_field.dart';
import '../widgets/divider_widget.dart';
import '../widgets/glowing_background.dart';
import '../widgets/password_text_field.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/gradient_button.dart';
import '../widgets/social_auth_button.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  void _handleLogin() {
    setState(() {
      _emailError = AuthValidators.validateEmail(_emailController.text);
      _passwordError = AuthValidators.validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      setState(() => _isLoading = true);
      print('🔑 تسجيل الدخول: ${_emailController.text}');
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
      });
    }
  }

  void _handleForgotPassword() {
    print('انتقال لصفحة إعادة تعيين كلمة المرور');
    // Navigator.push(...)
  }

  void _handleGoogleSignIn() => print('جوجل');
  void _handleFacebookSignIn() => print('فيسبوك');
  void _handlePhoneSignIn() => print('هاتف');

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
            GlowingBackground(),

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
                        icon: Icons.login_rounded,
                        title: 'مرحباً بعودتك',
                        subtitle: 'سجل دخول للمتابعة',
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
                            // البريد الإلكتروني
                            BasicTextField(
                              icon: Icons.email_outlined,
                              hintText: 'البريد الإلكتروني',
                              controller: _emailController,
                              errorText: _emailError,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: screenWidth * 0.05),

                            // كلمة المرور
                            PasswordTextField(
                              controller: _passwordController,
                              errorText: _passwordError,
                            ),
                            SizedBox(height: screenWidth * 0.03),

                            // رابط نسيت كلمة المرور (محاذاة لليمين)
                            Align(
                              alignment: Alignment.centerRight,
                              child: ForgotPasswordLink(
                                onTap: () {
                                  Get.to(ForgotPasswordScreen(),duration: Duration(milliseconds: 500),transition: Transition.zoom);

                                },
                              ),
                            ),

                            SizedBox(height: screenWidth * 0.04),

                            // زر تسجيل الدخول
                            GradientButton(
                              text: 'تسجيل الدخول',
                              onPressed: _handleLogin,
                              isLoading: _isLoading,
                              height: screenWidth * 0.14,
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            // خط التقسيم
                            DividerWithText(text: 'أو تابع بواسطة'),

                            SizedBox(height: screenWidth * 0.06),

                            // أزرار التواصل
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialAuthButton(
                                  icon: Icons.g_mobiledata,
                                  label: 'جوجل',
                                  onTap: _handleGoogleSignIn,
                                  iconColor: Color(0xFFDB4437),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                SocialAuthButton(
                                  icon: Icons.facebook,
                                  label: 'فيسبوك',
                                  onTap: _handleFacebookSignIn,
                                  iconColor: Color(0xFF4267B2),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                SocialAuthButton(
                                  icon: Icons.phone_iphone,
                                  label: 'هاتف',
                                  onTap:() {
                                    Get.to(PhoneInputScreen(),duration: Duration(milliseconds: 500),transition: Transition.zoom);
                                  },
                                  iconColor: Color(0xFF34A853),
                                ),
                              ],
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            // رابط إنشاء حساب جديد
                            Center(
                              child: AuthFooterLink(
                                prefixText: 'ليس لديك حساب؟ ',
                                linkText: 'أنشئ حساب',
                                onTap: () {
                                  Get.to(ModernSignUpScreen(),duration: Duration(milliseconds: 500),transition:Transition.rightToLeft);
                                },
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