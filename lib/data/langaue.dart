//NestedMapExample.getLanguage();

import 'package:flutter/material.dart';

Map<String, Map<String, String>> languageMap = {
  'ar': {
    /////////////login page/////////////
    'changePass': 'تغير كلمة السر',
    'pageLogin': 'صفحة تسجيل الدخول',
    'login': 'تسجيل الدخول',
    'userName': 'أسم المستخدم',
    'changePassword': 'تغير كلمة السر',
    'password': 'كلمة السر',
    'newPassword': 'كلمة السر الجديدة',
    'renewPassword': 'إعادة كتابة كلمة السر',
    'savepassword': 'حفظ كلمة السر',
    ///////////////// sign up page //////////////
    'pageSignUp': 'صفحة إنشاء مستخدم جديد',
    'firstName': 'اسم المستخدم',
    'secondName': 'اسم الجد',
    'address': 'العنوان',
    'saveAndLoginByAdmin': 'حفظ و الدخول بالادمن',
    'saveAndLoginByUser': 'حفظ و الدخول بالمستخدم الجديد',
    'messageFaildsEmpty': 'احد الحقول فارغة من فضلك ادخل جميع الحقول',
    ////////////////home page //////
    'addDriver': 'إضافة سائق',
    'addvehicle': 'إضافة عربية',
    'addprovider': 'إضافة موزع',
    'addTransportationFee': 'إضافة حمولة جديدة ',
    'report': 'شاشة التقرير',
    //////////tansportation fee
    'vehcile': 'السيارة',
    'drvier': 'السائق',
    'provider': 'الموزع',
    'providerDetails': 'تفصيل الموزع',
    'typeToSearchVehicle': 'البحث عن السيارة',
    'typeToSearchProvider': 'البحث عن الموزع',
    'typeToSearchProviderDerails': 'البحث عن تفصيل الموزع',
    'typeToSearchDriver': 'البحث عن السائق',
    'numberOfTon': 'عدد الأطنان',
    'dateRequest': 'تاريخ الطلب',
    'totalValue': 'إجمالي تكلفة الأطنان',
    'messageSuccess': 'تمت الإضافة بنجاح',
    'messageFaild': 'فشل في الإضافة',
    'tablTransportation': 'إضافة حمولة',
    'vehicle': 'عربية نقل',
    'driver': 'السائق',
    'requestDate': 'تاريخ الطلب',
    'addTransportation': 'إضافة حمولة جديدة',
    ///////////////report
    'allDataFromdate': 'جميع البيانات من تاريخ',
    'toDate': 'حتي تاريخ',
    '': '',
    'reportTransportationFee': 'تقرير بنقل الحمولة',
    'dateFrom': 'تاريخ من',
    'dateTo': 'تاريخ إلي',
    'backToHome': 'العودة للصفحة الرئيسية',
    'addNewUser': 'إضافة مستخدم جديد'
  },
  'en': {
    'changePass': 'Change Password',
    'pageLogin': 'Login Page',
    'login': 'Login',
    'userName': 'Username',
    'changePassword': 'Change Password',
    'password': 'Password',
    'newPassword': 'New Password',
    'renewPassword': 'Re-enter Password',
    'savepassword': 'Save Password',
    'pageSignUp': 'Sign Up Page',
    'firstName': 'First Name',
    'secondName': 'Last Name',
    'address': 'Address',
    'saveAndLoginByAdmin': 'Save and Login as Admin',
    'saveAndLoginByUser': 'Save and Login as New User',
    'messageFaildsEmpty':
        'One or more fields are empty, please fill in all fields',
    'addDriver': 'Add Driver',
    'addvehicle': 'Add Vehicle',
    'addprovider': 'Add Provider',
    'addTransportationFee': 'Add New Shipment',
    'report': 'Report Screen',
    'vehcile': 'Vehicle',
    'drvier': 'Driver',
    'provider': 'Provider',
    'providerDetails': 'Provider Details',
    'typeToSearchVehicle': 'Search for Vehicle',
    'typeToSearchProvider': 'Search for Provider',
    'typeToSearchProviderDerails': 'Search for Provider Details',
    'typeToSearchDriver': 'Search for Driver',
    'numberOfTon': 'Number of Tons',
    'dateRequest': 'Request Date',
    'totalValue': 'Total Ton Cost',
    'messageSuccess': 'Added Successfully',
    'messageFaild': 'Failed to Add',
    'tablTransportation': 'Add Shipment',
    'vehicle': 'Vehicle',
    'driver': 'Driver',
    'requestDate': 'Request Date',
    'addTransportation': 'Add New Shipment',
    'allDataFromdate': 'All Data From Date',
    'toDate': 'To Date',
    'reportTransportationFee': 'Report For Transportation Fee',
    'dateFrom': 'Date From',
    'dateTo': 'Date To',
    'backToHome': 'Back To Home',
    'addNewUser': 'Add New User'
  },
};
//getLanguage(context,'')  use
String getLanguage(BuildContext context, String key) {
  Locale currentLocal = Localizations.localeOf(context);
  //get current Local
  // Locale locale = Locale('ar');
  // Locale currentLocal = locale;
  if (currentLocal == const Locale('ar')) {
    return languageMap['ar']![key] ?? 'Key not found in Arabic';
  } else {
    return languageMap['en']![key] ?? 'Key not found in English';
  }
}
