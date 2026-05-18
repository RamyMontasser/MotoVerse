import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static late SharedPreferences pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setBool({required String key, required bool val}) async {
    await pref.setBool(key, val);
  }

  static bool? getBool({required String key}) {
    return pref.getBool(key);
  }

  static Future<void> setString({
    required String key,
    required String val,
  }) async {
    await pref.setString(key, val);
  }

  static String? getString({required String key}) {
    return pref.getString(key);
  }

  // Locale _appLocale = Locale(
  //   AppPref.getString(key: 'selectedLang') == 'English' ? 'en' : 'ar',
  // );

  // Locale get appLocale => _appLocale;

  // Future<void> changeLanguage(String langCode) async {
  //   if (_appLocale.languageCode == langCode) return;

  //   _appLocale = Locale(langCode);

  //   await AppPref.setString(
  //     key: 'selectedLang',
  //     val: langCode == 'en' ? 'English' : 'العربية',
  //   );

  //   static Future<void> toggleNotifications({required String key, required bool val}) async {
  //     val = !val;
  //     await pref.setBool(key, val);
  // }
  // }
}
