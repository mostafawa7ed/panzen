import 'package:flutter/material.dart';

//NestedMapExample.getLanguage();
class NestedMapExample {
  static Map<String, Map<String, String>> languageMap = {
    'ar': {
      'changePass': 'تغير كلمة السر',
      'login': 'تسجيل الدخول',
      'name': 'أسم المستخدم',
      'password': 'كلمة السر',
      'newPassword': 'كلمة السر الجديدة',
      'renewPassword': 'إعادة كتابة كلمة السر',
      'messageSuccess': 'تمت الإضافة بنجاح',
      'messageFaild': 'فشل في الإضافة',
      'tablTransportation': 'إضافة حمولة',
      'vehicle': 'عربية نقل',
      'provider': 'الشركة',
      'providerDetails': 'ثمن الطن الحالي من الشركة',
      'driver': 'السائق',
      'numberOfTon': 'عدد الأطنان',
      'requestDate': 'تاريخ الطلب',
      'totalValue': 'القيمة الإجمالية',
      'addTransportation': 'إضافة حمولة جديدة',
    },
    'en': {
      'changePass': 'Change Password',
      'login': 'Login',
      'name': 'Username',
      'password': 'Password',
      'newPassword': 'New Password',
      'renewPassword': 'Confirm New Password',
      'messageSuccess': 'Added successfully',
      'messageFaild': 'Addition failed',
      'tablTransportation': 'Add Load',
      'vehicle': 'Vehicle',
      'provider': 'Provider',
      'providerDetails': 'Current Ton Price from Provider',
      'driver': 'Driver',
      'numberOfTon': 'Number of Tons',
      'requestDate': 'Request Date',
      'totalValue': 'Total Value',
      'addTransportation': 'Add New Load',
    },
  };

  static String getLanguage(BuildContext context, String key) {
    //Locale currentLocale = Localizations.localeOf(context);
    //get current Local
    Locale locale = Locale('ar');
    Locale currentLocal = locale;
    if (currentLocal == locale) {
      return languageMap['ar']![key] ?? 'Key not found in Arabic';
    } else {
      return languageMap['en']![key] ?? 'Key not found in English';
    }
  }
}
