import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static late SharedPreferences pref;
  String _lang = 'ar';
  String get local => _lang;

  Future<void> saveLang(String val) async {
    pref.setString('selectedLang', val);
  }

  void setLang(String lang) {
    if (lang == _lang) return;
    _lang = lang;
    saveLang(lang);
    notifyListeners();
  }

  String? getLang() {
    return pref.getString('selectedLang');
  }

  init() async {
    pref = await SharedPreferences.getInstance();
    String? savedLang = getLang();

    if (savedLang != null) {
      // أ: لو المستخدم كان مختار لغة قبل كدة، نعتمدها
      _lang = savedLang;
    } else {
      // ب: لو دي أول مرة (مفيش حاجة محفوظة)، نشوف لغة الموبايل
      String deviceLang = ui.window.locale.languageCode;

      // ج: نتأكد إن لغة الموبايل مدعومة عندنا (عربي أو إنجليزي بس)
      if (deviceLang == 'ar' || deviceLang == 'en') {
        _lang = deviceLang;
      } else {
        // د: لو لغة الموبايل حاجة تانية (ألماني مثلاً)، نخليه إنجليزي افتراضي
        _lang = 'ar';
      }
    }
    notifyListeners();
  }
}
