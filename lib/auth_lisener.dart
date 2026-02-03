
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthListener {
  static final SupabaseClient _supabase = Supabase.instance.client;
  static bool _isInitialized = false;

  static void initialize() {
    if (_isInitialized) return;

    _supabase.auth.onAuthStateChange.listen((event) {
      print('🔔 Auth Event: ${event.event}');

      switch (event.event) {
        case AuthChangeEvent.passwordRecovery:
          print('🔄 رابط استعادة باسورد');
          break;

        case AuthChangeEvent.signedIn:
          print('🔑 تسجيل دخول ناجح');
          // Get.offAll(() => HomeScreen());
          break;

        case AuthChangeEvent.userUpdated:
          print('📧 تم تحديث بيانات المستخدم');
          Get.snackbar('تم', 'تم التحديث بنجاح');
          break;

        case AuthChangeEvent.signedOut:
          print('🚪 تسجيل خروج');
          // Get.offAll(() => LoginScreen());
          break;

        default:
          print('⚡ حدث آخر: ${event.event}');
      }
    });

    _isInitialized = true;
    print('✅ AuthListener initialized');
  }

  static void dispose() {
    _isInitialized = false;
  }
}
