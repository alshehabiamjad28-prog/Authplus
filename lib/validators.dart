class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'البريد مطلوب';
    if (!value.contains('@')) return 'بريد غير صحيح';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
    if (value.length < 6) return '6 أحرف على الأقل';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'الاسم مطلوب';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'الهاتف مطلوب';
    if (value.length < 10) return 'رقم غير صحيح';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'تأكيد كلمة المرور مطلوب';
    if (value != password) return 'غير متطابق';
    return null;
  }

  static String? validateResetEmail(String? value) {
  if (value == null || value.isEmpty) return 'البريد مطلوب';
  if (!value.contains('@')) return 'بريد غير صحيح';
  return null;
  }

}