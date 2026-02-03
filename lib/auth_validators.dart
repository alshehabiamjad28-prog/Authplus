class AuthValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'أدخل الاسم';
    if (value.trim().length < 3) return '3 أحرف على الأقل';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'أدخل الإيميل';
    if (!value.contains('@')) return 'إيميل غير صالح';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
    if (value.length < 6) return '6 أحرف على الأقل';
    return null;
  }

  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }

    // تنظيف الرقم (إزالة المسافات والشارات)
    final cleanedPhone = value.replaceAll(RegExp(r'[+\s-]'), '');

    // التحقق من الأرقام فقط
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedPhone)) {
      return 'يجب أن يحتوي على أرقام فقط';
    }

    // التحقق من الطول
    if (cleanedPhone.length < 10 || cleanedPhone.length > 15) {
      return 'رقم هاتف غير صالح (10-15 رقم)';
    }

    return null;
  }


}