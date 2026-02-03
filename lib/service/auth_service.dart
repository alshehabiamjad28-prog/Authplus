import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabaseAuth = Supabase.instance.client.auth;
  final supabaseClient = Supabase.instance.client;
  final supabase = Supabase.instance.client;

  /// تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  /// يُرجع true إذا نجح التسجيل، false إذا فشل
  Future<bool> signIn(String email, String password) async {
    try {
      // 1. تسجيل الدخول
      final users = await supabaseAuth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (users.user != null) {
        // 2. جلب حالة الحساب من profiles
        final response = await supabaseClient
            .from('profiles')
            .select('is_active')
            .eq('id', users.user!.id)
            .single();

        // 3. التحقق إذا كان الحساب نشطاً
        final isActive = response['is_active'] as bool? ?? true;

        if (!isActive) {
          // 4. إذا كان معطلاً، نطرده
          await supabaseAuth.signOut();
          print('❌ الحساب معطل');
          return false;
        }

        print('✅ تم تسجيل الدخول بنجاح');
        return true;
      }

      return false;
    } catch (e) {
      print('❌ خطأ في تسجيل الدخول: ${e.toString()}');
      return false;
    }
  }

  /// إنشاء حساب جديد بالبريد الإلكتروني وكلمة المرور
  /// يُرجع true إذا نجح الإنشاء، false إذا فشل
  Future<bool> signUp(String email, String password, String name) async {
    try {
      // 1. إنشاء حساب في المصادقة
      final response = await supabaseAuth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name},
      );

      // 2. إذا نجح، أضف بيانات في profiles
      if (response.user != null) {
        await supabaseClient.from('profiles').insert({
          'id': response.user!.id, // نفس الـ ID
          'full_name': name, // الاسم
          'is_active': true, // الحساب نشط
          'created_at': DateTime.now().toIso8601String(),
        });

        print('✅ تم إنشاء الحساب وإضافة البيانات');
        return true;
      }

      return false;
    } catch (e) {
      print('❌ خطأ في إنشاء الحساب: ${e.toString()}');
      return false;
    }
  }

  /// تسجيل الخروج من الحساب الحالي
  /// يُرجع true إذا نجح الخروج، false إذا فشل
  Future<bool> signOut() async {
    try {
      await supabaseAuth.signOut();
      print('✅ تم تسجيل الخروج بنجاح');
      return true;
    } catch (e) {
      print('❌ خطأ في تسجيل الخروج: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deactivateAccount() async {
    try {
      final userId = supabaseAuth.currentUser?.id;

      if (userId == null) {
        print('⚠️ لا يوجد مستخدم مسجل');
        return false;
      }

      // 1. تحديث حالة الحساب في profiles
      await supabaseClient
          .from('profiles')
          .update({
            'is_active': false,
            'deleted_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);

      // 2. تسجيل الخروج
      await supabaseAuth.signOut();

      print('✅ تم تعطيل الحساب وتسجيل الخروج');
      return true;
    } catch (e) {
      print('❌ خطأ في تعطيل الحساب: ${e.toString()}');
      return false;
    }
  }

  /// التحقق مما إذا كان هناك مستخدم مسجل دخوله حالياً
  /// يُرجع true إذا كان هناك مستخدم مسجل، false إذا لم يكن
  bool isUserLoggedIn() {
    final currentUser = supabaseAuth.currentUser;
    return currentUser != null;
  }

  /// الحصول على بيانات المستخدم الحالي
  User? getCurrentUser() {
    return supabaseAuth.currentUser;
  }

  //////////////    ////////////////
  ////////Reset/    /Password////////
  //////////////   ///////////////


  Future<bool> sendResetCode(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'com.authproject.app://reset-password',
      );

      return true;
    } catch (e) {
      return false;
    }
  }



  Future<bool> verifyResetCode(String email, String code) async {
    try {
      await supabase.auth.verifyOTP(
        email: email,
        token: code,
        type: OtpType.recovery,
      );
      print('scssess');
      return true;
    } catch (e) {
      print('erorr');
      print(e.runtimeType);
      return false;
    }
  }




  Future<bool> resetPassword(String newPassword, String emal) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword, data: {'hhh': emal}),
      );
      print('scssess');

      return true;
    } catch (e) {
      print('erorr');
      print(e.runtimeType);
      return false;
    }
  }

  // 4️⃣ التحقق من حالة المستخدم
  bool isUserVerifiedForReset() {
    final session = supabase.auth.currentSession;
    return session != null;
  }

  ////////////////////////////////////////////
  //////////////verifySignupCode///////////////
  ////////////////////////////////////////////
  Future<bool> verifySignupCode(String email, String code) async {
    print('📧 البريد: $email');
    print('🔢 الكود المدخل: $code');

    try {
      await supabase.auth.verifyOTP(
        email: email,
        token: code,
        type: OtpType.signup,
      );
      print('✅ تم النجاح');
      return true;
    } catch (e) {
      print('❌ فشل');
      print(e);
      return false;
    }
  }

  Future<bool> createAccount(String email, String password) async {
    print('📧 البريد: $email');

    try {
      await supabase.auth.signUp(email: email, password: password,);
      print('✅ تم إنشاء الحساب وإرسال كود التفعيل');
      return true;
    } catch (e) {
      print('❌ فشل إنشاء الحساب');
      print(e);
      return false;
    }
  }

  ///////////////////////////
  /////////change email//////
  ///////////////////////////

  Future<bool> verifyEmailChangeCode(String newEmail, String code) async {
    print('📧 البريد الجديد: $newEmail');
    print('🔢 الكود المدخل: $code');

    try {
      await supabase.auth.verifyOTP(
        email: newEmail,
        token: code,
        type: OtpType.emailChange,
      );
      print('✅ تم تغيير البريد بنجاح');
      return true;
    } catch (e) {
      print('❌ فشل تغيير البريد');
      print(e);
      return false;
    }
  }

  Future<bool> requestEmailChange(String newEmail) async {
    try {
      await supabase.auth.updateUser(UserAttributes(email: newEmail));
      print('✅ تم إرسال كود التحقق إلى: $newEmail');
      return true;
    } catch (e) {
      print('❌ فشل طلب تغيير البريد: $e');
      return false;
    }
  }

  ////////////////////////////////////////////////////////////////////
  /////////////////////////Signin With OTP  MgicLink////////////////////////////
  ////////////////////////////////////////////////////////////////////
  Future<bool> sendLoginCode(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'com.authproject.app://auth-callback',
      );
      print('✅ تم إرسال كود تسجيل الدخول');
      return true;
    } catch (e) {
      print('❌ فشل إرسال الكود: $e');
      return false;
    }
  }

  Future<bool> verifyLoginCode(String email, String code) async {
    print('📧 البريد: $email');
    print('🔢 الكود المدخل: $code');

    try {
      await supabase.auth.verifyOTP(
        email: email,
        token: code,
        type: OtpType.magiclink,
      );
      print('✅ تم تسجيل الدخول بنجاح');
      return true;
    } catch (e) {
      print('❌ فشل تسجيل الدخول');
      print(e);
      return false;
    }
  }

  ////////////////////////////////////////////////////////////////////////

  Future<bool> sendPhoneCode(String phone) async {
    try {
      await supabase.auth.signInWithOtp(phone: phone,);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }







  Future<void> signInWithGoogle() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,

        redirectTo: 'com.authproject.app://auth-callback',
      );
      print('✅ تم تسجيل الدخول بجوجل');
    } catch (e) {
      print('❌ خطأ: $e');
    }
  }

  Future<void> signInWithfacebook() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.facebook,

        redirectTo: 'com.authproject.app://auth-callback',
      );
      print('✅ تم تسجيل الدخول بجوجل');
    } catch (e) {
      print('❌ خطأ: $e');
    }
  }




}
