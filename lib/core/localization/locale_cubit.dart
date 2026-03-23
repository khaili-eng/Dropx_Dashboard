import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleInitial());

  Locale _currentLocale = const Locale('ar');

  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    emit(LocaleChanged(_currentLocale));
  }

  Locale get currentLocale => _currentLocale;


  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
     'login':'Login Now',
      'aa':'Manage your restaurant with Ease',
      'bb':'Welcome Back to Maadati',
      'cc':'Enter your Phone Number',
      'dd':'Enter your Password',
      'ee':'Phone number is required',
      'ff':'Use the format 09xxxxxxxx',
      'gg':'Minimum 6 characters'

    },
    'ar': {
      'login':'سجل دخولك الآن',
      'aa':'تحكم في مطعمك بكل سهولة',
      'bb':'مرحباً بعودتك إلى تطبيق مائدتي',
      'cc':'أدخل رقم هاتفك ',
      'dd':'أدخل كلمة مرورك ',
      'ee':'  رقم الهاتف مطلوب  ',
      'ff':'  اكتب رقم الهاتف بالشكل 09xxxxxxxxx  ',
      'gg':'الحد الأدنى 6 أحرف'









    },
  };

  String translate(String key ) {
    return _localizedValues[_currentLocale.languageCode]?[key] ?? key;
  }
}
