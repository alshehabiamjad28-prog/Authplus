import 'package:authproject/screens/phone_input_screen.dart';
import 'package:authproject/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../auth_validators.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/divider_widget.dart';
import '../widgets/glowing_background.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/basic_text_field.dart';
import '../widgets/password_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/social_auth_button.dart';


class ModernSignUpScreen extends StatefulWidget {
  @override
  _ModernSignUpScreenState createState() => _ModernSignUpScreenState();
}

class _ModernSignUpScreenState extends State<ModernSignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  void _validateAndSubmit() {
    setState(() {
      _nameError = AuthValidators.validateName(_nameController.text);
      _emailError = AuthValidators.validateEmail(_emailController.text);
      _passwordError = AuthValidators.validatePassword(_passwordController.text);
    });

    if (_nameError == null && _emailError == null && _passwordError == null) {
      print('✅ التسجيل ناجح: ${_emailController.text}');
    }
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
            stops: [0.0, 0.8],
          ),
        ),
        child: Stack(
          children: [
            // 1. الخلفية المضيئة
            GlowingBackground(),

            // 2. المحتوى الرئيسي
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
                        icon: Icons.rocket_launch_outlined,
                        title: 'ابدأ رحلتك',
                        subtitle: 'أنشئ حسابك في دقائق',
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
                              icon: Icons.person_outline_rounded,
                              hintText: 'الاسم الكامل',
                              controller: _nameController,
                              errorText: _nameError,
                            ),
                            SizedBox(height: screenWidth * 0.05),

                            BasicTextField(
                              icon: Icons.email_outlined,
                              hintText: 'البريد الإلكتروني',
                              controller: _emailController,
                              errorText: _emailError,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: screenWidth * 0.05),

                            PasswordTextField(
                              controller: _passwordController,
                              errorText: _passwordError,
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            GradientButton(
                              text: 'إنشاء حساب',
                              onPressed: _validateAndSubmit,
                              height: screenWidth * 0.14,
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            DividerWithText(text: 'أو تابع بواسطة'),

                            SizedBox(height: screenWidth * 0.06),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialAuthButton(
                                  icon: Icons.g_mobiledata,
                                  label: 'جوجل',
                                  onTap: () => print('جوجل'),
                                  iconColor: Color(0xFFDB4437),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                SocialAuthButton(
                                  icon: Icons.facebook,
                                  label: 'فيسبوك',
                                  onTap: () => print('فيسبوك'),
                                  iconColor: Color(0xFF4267B2),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                SocialAuthButton(
                                  icon: Icons.phone_iphone,
                                  label: 'هاتف',
                                  onTap: () {
                                    Get.to(PhoneInputScreen(),duration: Duration(milliseconds: 500),transition: Transition.zoom);

                                  },
                                  iconColor: Color(0xFF34A853),
                                ),
                              ],
                            ),

                            SizedBox(height: screenWidth * 0.08),

                            Center(
                              child: AuthFooterLink(
                                prefixText: 'لديك حساب بالفعل؟ ',
                                linkText: 'سجل دخول',
                                onTap: () {
                                  Get.to(LoginScreen(),duration: Duration(milliseconds: 500),transition:Transition.leftToRight );

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