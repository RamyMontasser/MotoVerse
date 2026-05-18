import 'package:flutter/material.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    if (navigatorKey.currentContext != null) {
      return Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(routeName, (route) => false);
    }
    return Future.error('Navigator key is null');
  }
}
