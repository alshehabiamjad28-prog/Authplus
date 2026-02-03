import 'package:flutter/material.dart';
import '../auth_validators.dart';
import '../widgets/auth_footerlink.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/password_text_field.dart';
import '../widgets/gradient_button.dart';


class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _newPasswordError;
  String? _confirmPasswordError;
  bool _isLoading = false;

  void _updatePassword() {
    setState(() {
      _newPasswordError = AuthValidators.validatePassword(_newPasswordController.text);
      _confirmPasswordError = AuthValidators.validatePasswordMatch(
        _newPasswordController.text,
        _confirmPasswordController.text,
      );
    });

    if (_newPasswordError == null && _confirmPasswordError == null) {
      setState(() => _isLoading = true);
      print('🔐 تحديث كلمة المرور');
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        print('✅ تم التحديث بنجاح!');
      });
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
            colors: [Color(0xFF0F0F1E), Color(0xFF1A1A2E)],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),

                    AuthHeaderWidget(
                      icon: Icons.lock_open_outlined,
                      title: 'كلمة مرور جديدة',
                      subtitle: 'اختر كلمة مرور جديدة لحسابك',
                    ),

                    SizedBox(height: screenHeight * 0.08),

                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Column(
                        children: [
                          PasswordTextField(
                            controller: _newPasswordController,
                            errorText: _newPasswordError,


                          ),
                          SizedBox(height: 20),

                          PasswordTextField(
                            controller: _confirmPasswordController,
                            errorText: _confirmPasswordError,

                          ),

                          SizedBox(height: 30),

                          GradientButton(
                            text: 'تحديث كلمة المرور',
                            onPressed: _updatePassword,
                            isLoading: _isLoading,
                          ),

                          SizedBox(height: 20),

                          Text(
                            'تأكد من أن كلمة المرور قوية وتحتوي على أحرف وأرقام',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(height: 30),

                          AuthFooterLink(
                            prefixText: 'العودة إلى ',
                            linkText: 'تسجيل الدخول',
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