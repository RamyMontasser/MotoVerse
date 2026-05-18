// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(price) => "${price} EGP";

  static String m1(number) => "We sent a verification code to\n${number}";

  static String m2(price) => "${price}M EGP";

  static String m3(price) => "${price}K EGP";

  static String m4(min, max) => "Price Range: ${min} - ${max}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
    "aboutUsDesc": MessageLookupByLibrary.simpleMessage(
      "Learn about MotoServe platform",
    ),
    "addPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Add your phone number",
    ),
    "allCars": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("App Language"),
    "appName": MessageLookupByLibrary.simpleMessage("MotoServe"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "automatic": MessageLookupByLibrary.simpleMessage("Automatic"),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "carType": MessageLookupByLibrary.simpleMessage("Car Type"),
    "compare": MessageLookupByLibrary.simpleMessage("Compare"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Phone Number",
    ),
    "copyrights": MessageLookupByLibrary.simpleMessage(
      "© 2025 All rights reserved",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createNewAccount": MessageLookupByLibrary.simpleMessage(
      "Create New Account",
    ),
    "createPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Create Password",
    ),
    "currency": m0,
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "details": MessageLookupByLibrary.simpleMessage("View Details"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email Address"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "featureCompare": MessageLookupByLibrary.simpleMessage("Car Comparison"),
    "featureCompareDesc": MessageLookupByLibrary.simpleMessage(
      "Compare models and specs easily to make the best decision.",
    ),
    "featureCost": MessageLookupByLibrary.simpleMessage("Cost Estimation"),
    "featureCostDesc": MessageLookupByLibrary.simpleMessage(
      "Calculate ownership and maintenance costs before buying.",
    ),
    "featureMaintenance": MessageLookupByLibrary.simpleMessage(
      "Maintenance Tracking",
    ),
    "featureMaintenanceDesc": MessageLookupByLibrary.simpleMessage(
      "Track your car status and remember maintenance dates easily.",
    ),
    "featureMap": MessageLookupByLibrary.simpleMessage("Centers Map"),
    "featureMapDesc": MessageLookupByLibrary.simpleMessage(
      "Find the nearest trusted service center with location services.",
    ),
    "featurePricePredict": MessageLookupByLibrary.simpleMessage(
      "Price Prediction",
    ),
    "featurePricePredictDesc": MessageLookupByLibrary.simpleMessage(
      "Know the future value of your car before buying or selling.",
    ),
    "featureRecommend": MessageLookupByLibrary.simpleMessage(
      "Smart Recommendation",
    ),
    "featureRecommendDesc": MessageLookupByLibrary.simpleMessage(
      "We help you choose the perfect car for your budget and needs.",
    ),
    "featuredCars": MessageLookupByLibrary.simpleMessage("Featured Cars"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "homePage": MessageLookupByLibrary.simpleMessage("Home"),
    "homeSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search for a car, service, or center...",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "manual": MessageLookupByLibrary.simpleMessage("Manual"),
    "marketSearchHint": MessageLookupByLibrary.simpleMessage("Search about"),
    "myCars": MessageLookupByLibrary.simpleMessage("My Cars & History"),
    "newAdvantage": MessageLookupByLibrary.simpleMessage("New Advantage"),
    "newCar": MessageLookupByLibrary.simpleMessage("New"),
    "newCars": MessageLookupByLibrary.simpleMessage("New"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "notifMaintenance": MessageLookupByLibrary.simpleMessage(
      "Maintenance Reminders",
    ),
    "notifMaintenanceDesc": MessageLookupByLibrary.simpleMessage(
      "Reminders for periodic maintenance dates",
    ),
    "notifMessages": MessageLookupByLibrary.simpleMessage("Messages"),
    "notifMessagesDesc": MessageLookupByLibrary.simpleMessage(
      "Message notifications from sellers and centers",
    ),
    "notifNewCars": MessageLookupByLibrary.simpleMessage(
      "New Car Notifications",
    ),
    "notifNewCarsDesc": MessageLookupByLibrary.simpleMessage(
      "Alerts when new cars are added",
    ),
    "notifPriceChange": MessageLookupByLibrary.simpleMessage("Price Changes"),
    "notifPriceChangeDesc": MessageLookupByLibrary.simpleMessage(
      "Alerts when favorite car prices change",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Your Smart Guide to Cars",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Be smarter in choosing your car",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "All your car needs in one place",
    ),
    "onboarding4": MessageLookupByLibrary.simpleMessage(
      "Start Your Smart Journey now",
    ),
    "otpSentMessage": m1,
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "personalSettings": MessageLookupByLibrary.simpleMessage(
      "Personal Settings",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "priceInMillions": m2,
    "priceInThousands": m3,
    "priceRange": m4,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacyPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "View Privacy Policy",
    ),
    "privacySecurity": MessageLookupByLibrary.simpleMessage(
      "Privacy & Security",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileDesc": MessageLookupByLibrary.simpleMessage(
      "View and edit your personal info",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "restorePassword": MessageLookupByLibrary.simpleMessage("Restore Password"),
    "restorePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number to restore password",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchCountry": MessageLookupByLibrary.simpleMessage("Search Country"),
    "selectBrand": MessageLookupByLibrary.simpleMessage("Select Brand"),
    "selectCarType": MessageLookupByLibrary.simpleMessage("Select Type"),
    "selectCountry": MessageLookupByLibrary.simpleMessage("Select Country"),
    "selectYear": MessageLookupByLibrary.simpleMessage("Select Year"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsDesc": MessageLookupByLibrary.simpleMessage(
      "App settings and notifications",
    ),
    "smartDiagnosis": MessageLookupByLibrary.simpleMessage(
      "Smart diagnosis of faults",
    ),
    "smartDiagnosisSubtitle": MessageLookupByLibrary.simpleMessage(
      "Understand your car\'s problem through AI-based analysis.",
    ),
    "startDiagnosis": MessageLookupByLibrary.simpleMessage("Start Diagnosis"),
    "startJourney": MessageLookupByLibrary.simpleMessage("Start Your Journey"),
    "termsLink": MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
    "termsOfUse": MessageLookupByLibrary.simpleMessage("Terms of Use"),
    "termsOfUseDesc": MessageLookupByLibrary.simpleMessage(
      "Terms and conditions of use",
    ),
    "termsText": MessageLookupByLibrary.simpleMessage(
      "By creating an account, you agree to our ",
    ),
    "tipsBody": MessageLookupByLibrary.simpleMessage(
      "• Use Smart Recommendation if you are unsure about choosing \n• Compare multiple cars before the final decision \n• Calculate total cost to avoid financial surprises \n• Track maintenance regularly to keep your car\'s value",
    ),
    "tipsTitle": MessageLookupByLibrary.simpleMessage("💡 Tool Usage Tips"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateInfo": MessageLookupByLibrary.simpleMessage(
      "Update your personal information",
    ),
    "usedCar": MessageLookupByLibrary.simpleMessage("Used"),
    "usedCars": MessageLookupByLibrary.simpleMessage("Used"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Welcome back! Login to your account or ",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome"),
    "year": MessageLookupByLibrary.simpleMessage("Year"),
  };
}
