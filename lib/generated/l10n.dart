// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MotoServe`
  String get appName {
    return Intl.message('MotoServe', name: 'appName', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `View Details`
  String get details {
    return Intl.message('View Details', name: 'details', desc: '', args: []);
  }

  /// `Compare`
  String get compare {
    return Intl.message('Compare', name: 'compare', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `{price} EGP`
  String currency(Object price) {
    return Intl.message(
      '$price EGP',
      name: 'currency',
      desc: '',
      args: [price],
    );
  }

  /// `{price}M EGP`
  String priceInMillions(Object price) {
    return Intl.message(
      '${price}M EGP',
      name: 'priceInMillions',
      desc: '',
      args: [price],
    );
  }

  /// `{price}K EGP`
  String priceInThousands(Object price) {
    return Intl.message(
      '${price}K EGP',
      name: 'priceInThousands',
      desc: '',
      args: [price],
    );
  }

  /// `Price Range: {min} - {max}`
  String priceRange(Object min, Object max) {
    return Intl.message(
      'Price Range: $min - $max',
      name: 'priceRange',
      desc: '',
      args: [min, max],
    );
  }

  /// `Welcome`
  String get welcomeTitle {
    return Intl.message('Welcome', name: 'welcomeTitle', desc: '', args: []);
  }

  /// `Welcome back! Login to your account or `
  String get welcomeSubtitle {
    return Intl.message(
      'Welcome back! Login to your account or ',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Add your phone number`
  String get addPhoneNumber {
    return Intl.message(
      'Add your phone number',
      name: 'addPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to our `
  String get termsText {
    return Intl.message(
      'By creating an account, you agree to our ',
      name: 'termsText',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsLink {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsLink',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Phone Number`
  String get confirmPhoneTitle {
    return Intl.message(
      'Confirm Phone Number',
      name: 'confirmPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `We sent a verification code to\n{number}`
  String otpSentMessage(Object number) {
    return Intl.message(
      'We sent a verification code to\n$number',
      name: 'otpSentMessage',
      desc: '',
      args: [number],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Password`
  String get createPasswordTitle {
    return Intl.message(
      'Create Password',
      name: 'createPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Restore Password`
  String get restorePassword {
    return Intl.message(
      'Restore Password',
      name: 'restorePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number to restore password`
  String get restorePasswordSubtitle {
    return Intl.message(
      'Enter your phone number to restore password',
      name: 'restorePasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Smart Guide to Cars`
  String get onboarding1 {
    return Intl.message(
      'Your Smart Guide to Cars',
      name: 'onboarding1',
      desc: '',
      args: [],
    );
  }

  /// `Be smarter in choosing your car`
  String get onboarding2 {
    return Intl.message(
      'Be smarter in choosing your car',
      name: 'onboarding2',
      desc: '',
      args: [],
    );
  }

  /// `All your car needs in one place`
  String get onboarding3 {
    return Intl.message(
      'All your car needs in one place',
      name: 'onboarding3',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Journey`
  String get startJourney {
    return Intl.message(
      'Start Your Journey',
      name: 'startJourney',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Smart Journey now`
  String get onboarding4 {
    return Intl.message(
      'Start Your Smart Journey now',
      name: 'onboarding4',
      desc: '',
      args: [],
    );
  }

  /// `Understand your car's problem through AI-based analysis.`
  String get smartDiagnosisSubtitle {
    return Intl.message(
      'Understand your car\'s problem through AI-based analysis.',
      name: 'smartDiagnosisSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Diagnosis`
  String get startDiagnosis {
    return Intl.message(
      'Start Diagnosis',
      name: 'startDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message('Home', name: 'homePage', desc: '', args: []);
  }

  /// `Search for a car, service, or center...`
  String get homeSearchHint {
    return Intl.message(
      'Search for a car, service, or center...',
      name: 'homeSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search about`
  String get marketSearchHint {
    return Intl.message(
      'Search about',
      name: 'marketSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `New Advantage`
  String get newAdvantage {
    return Intl.message(
      'New Advantage',
      name: 'newAdvantage',
      desc: '',
      args: [],
    );
  }

  /// `Smart diagnosis of faults`
  String get smartDiagnosis {
    return Intl.message(
      'Smart diagnosis of faults',
      name: 'smartDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Featured Cars`
  String get featuredCars {
    return Intl.message(
      'Featured Cars',
      name: 'featuredCars',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newCars {
    return Intl.message('New', name: 'newCars', desc: '', args: []);
  }

  /// `Used`
  String get usedCars {
    return Intl.message('Used', name: 'usedCars', desc: '', args: []);
  }

  /// `All`
  String get allCars {
    return Intl.message('All', name: 'allCars', desc: '', args: []);
  }

  /// `New`
  String get newCar {
    return Intl.message('New', name: 'newCar', desc: '', args: []);
  }

  /// `Used`
  String get usedCar {
    return Intl.message('Used', name: 'usedCar', desc: '', args: []);
  }

  /// `Car Comparison`
  String get featureCompare {
    return Intl.message(
      'Car Comparison',
      name: 'featureCompare',
      desc: '',
      args: [],
    );
  }

  /// `Compare models and specs easily to make the best decision.`
  String get featureCompareDesc {
    return Intl.message(
      'Compare models and specs easily to make the best decision.',
      name: 'featureCompareDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cost Estimation`
  String get featureCost {
    return Intl.message(
      'Cost Estimation',
      name: 'featureCost',
      desc: '',
      args: [],
    );
  }

  /// `Calculate ownership and maintenance costs before buying.`
  String get featureCostDesc {
    return Intl.message(
      'Calculate ownership and maintenance costs before buying.',
      name: 'featureCostDesc',
      desc: '',
      args: [],
    );
  }

  /// `Centers Map`
  String get featureMap {
    return Intl.message('Centers Map', name: 'featureMap', desc: '', args: []);
  }

  /// `Find the nearest trusted service center with location services.`
  String get featureMapDesc {
    return Intl.message(
      'Find the nearest trusted service center with location services.',
      name: 'featureMapDesc',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Tracking`
  String get featureMaintenance {
    return Intl.message(
      'Maintenance Tracking',
      name: 'featureMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Track your car status and remember maintenance dates easily.`
  String get featureMaintenanceDesc {
    return Intl.message(
      'Track your car status and remember maintenance dates easily.',
      name: 'featureMaintenanceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Price Prediction`
  String get featurePricePredict {
    return Intl.message(
      'Price Prediction',
      name: 'featurePricePredict',
      desc: '',
      args: [],
    );
  }

  /// `Know the future value of your car before buying or selling.`
  String get featurePricePredictDesc {
    return Intl.message(
      'Know the future value of your car before buying or selling.',
      name: 'featurePricePredictDesc',
      desc: '',
      args: [],
    );
  }

  /// `Smart Recommendation`
  String get featureRecommend {
    return Intl.message(
      'Smart Recommendation',
      name: 'featureRecommend',
      desc: '',
      args: [],
    );
  }

  /// `We help you choose the perfect car for your budget and needs.`
  String get featureRecommendDesc {
    return Intl.message(
      'We help you choose the perfect car for your budget and needs.',
      name: 'featureRecommendDesc',
      desc: '',
      args: [],
    );
  }

  /// `💡 Tool Usage Tips`
  String get tipsTitle {
    return Intl.message(
      '💡 Tool Usage Tips',
      name: 'tipsTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Use Smart Recommendation if you are unsure about choosing \n• Compare multiple cars before the final decision \n• Calculate total cost to avoid financial surprises \n• Track maintenance regularly to keep your car's value`
  String get tipsBody {
    return Intl.message(
      '• Use Smart Recommendation if you are unsure about choosing \n• Compare multiple cars before the final decision \n• Calculate total cost to avoid financial surprises \n• Track maintenance regularly to keep your car\'s value',
      name: 'tipsBody',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Search Country`
  String get searchCountry {
    return Intl.message(
      'Search Country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message('Brand', name: 'brand', desc: '', args: []);
  }

  /// `Select Brand`
  String get selectBrand {
    return Intl.message(
      'Select Brand',
      name: 'selectBrand',
      desc: '',
      args: [],
    );
  }

  /// `Car Type`
  String get carType {
    return Intl.message('Car Type', name: 'carType', desc: '', args: []);
  }

  /// `Select Type`
  String get selectCarType {
    return Intl.message(
      'Select Type',
      name: 'selectCarType',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Select Year`
  String get selectYear {
    return Intl.message('Select Year', name: 'selectYear', desc: '', args: []);
  }

  /// `Automatic`
  String get automatic {
    return Intl.message('Automatic', name: 'automatic', desc: '', args: []);
  }

  /// `Manual`
  String get manual {
    return Intl.message('Manual', name: 'manual', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `View and edit your personal info`
  String get profileDesc {
    return Intl.message(
      'View and edit your personal info',
      name: 'profileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `My Cars & History`
  String get myCars {
    return Intl.message(
      'My Cars & History',
      name: 'myCars',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Learn about MotoServe platform`
  String get aboutUsDesc {
    return Intl.message(
      'Learn about MotoServe platform',
      name: 'aboutUsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `App settings and notifications`
  String get settingsDesc {
    return Intl.message(
      'App settings and notifications',
      name: 'settingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Personal Settings`
  String get personalSettings {
    return Intl.message(
      'Personal Settings',
      name: 'personalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update your personal information`
  String get updateInfo {
    return Intl.message(
      'Update your personal information',
      name: 'updateInfo',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get privacySecurity {
    return Intl.message(
      'Privacy & Security',
      name: 'privacySecurity',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `View Privacy Policy`
  String get privacyPolicyDesc {
    return Intl.message(
      'View Privacy Policy',
      name: 'privacyPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message('Terms of Use', name: 'termsOfUse', desc: '', args: []);
  }

  /// `Terms and conditions of use`
  String get termsOfUseDesc {
    return Intl.message(
      'Terms and conditions of use',
      name: 'termsOfUseDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `© 2025 All rights reserved`
  String get copyrights {
    return Intl.message(
      '© 2025 All rights reserved',
      name: 'copyrights',
      desc: '',
      args: [],
    );
  }

  /// `New Car Notifications`
  String get notifNewCars {
    return Intl.message(
      'New Car Notifications',
      name: 'notifNewCars',
      desc: '',
      args: [],
    );
  }

  /// `Alerts when new cars are added`
  String get notifNewCarsDesc {
    return Intl.message(
      'Alerts when new cars are added',
      name: 'notifNewCarsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Price Changes`
  String get notifPriceChange {
    return Intl.message(
      'Price Changes',
      name: 'notifPriceChange',
      desc: '',
      args: [],
    );
  }

  /// `Alerts when favorite car prices change`
  String get notifPriceChangeDesc {
    return Intl.message(
      'Alerts when favorite car prices change',
      name: 'notifPriceChangeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Reminders`
  String get notifMaintenance {
    return Intl.message(
      'Maintenance Reminders',
      name: 'notifMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Reminders for periodic maintenance dates`
  String get notifMaintenanceDesc {
    return Intl.message(
      'Reminders for periodic maintenance dates',
      name: 'notifMaintenanceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get notifMessages {
    return Intl.message('Messages', name: 'notifMessages', desc: '', args: []);
  }

  /// `Message notifications from sellers and centers`
  String get notifMessagesDesc {
    return Intl.message(
      'Message notifications from sellers and centers',
      name: 'notifMessagesDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
