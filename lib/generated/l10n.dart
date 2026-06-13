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

  /// `Start Your Journey`
  String get startJourney {
    return Intl.message(
      'Start Your Journey',
      name: 'startJourney',
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

  /// `Quick Services`
  String get quickServices {
    return Intl.message(
      'Quick Services',
      name: 'quickServices',
      desc: '',
      args: [],
    );
  }

  /// `Request Help`
  String get requestHelp {
    return Intl.message(
      'Request Help',
      name: 'requestHelp',
      desc: '',
      args: [],
    );
  }

  /// `Emergency support`
  String get emergencySupport {
    return Intl.message(
      'Emergency support',
      name: 'emergencySupport',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Centers`
  String get nearbyMaintenance {
    return Intl.message(
      'Nearby Centers',
      name: 'nearbyMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `{count} centers near you`
  String nearestCentersCount(Object count) {
    return Intl.message(
      '$count centers near you',
      name: 'nearestCentersCount',
      desc: '',
      args: [count],
    );
  }

  /// `No nearby centers currently`
  String get noNearbyCenters {
    return Intl.message(
      'No nearby centers currently',
      name: 'noNearbyCenters',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance History`
  String get maintenanceHistory {
    return Intl.message(
      'Maintenance History',
      name: 'maintenanceHistory',
      desc: '',
      args: [],
    );
  }

  /// `Last maintenance: Loading current technical data...`
  String get loadingTechnicalData {
    return Intl.message(
      'Last maintenance: Loading current technical data...',
      name: 'loadingTechnicalData',
      desc: '',
      args: [],
    );
  }

  /// `Last maintenance: {service} – {date}`
  String lastMaintenanceDetails(Object service, Object date) {
    return Intl.message(
      'Last maintenance: $service – $date',
      name: 'lastMaintenanceDetails',
      desc: '',
      args: [service, date],
    );
  }

  /// `No maintenance history yet`
  String get noMaintenanceHistory {
    return Intl.message(
      'No maintenance history yet',
      name: 'noMaintenanceHistory',
      desc: '',
      args: [],
    );
  }

  /// `My Current Offers`
  String get myCurrentOffers {
    return Intl.message(
      'My Current Offers',
      name: 'myCurrentOffers',
      desc: '',
      args: [],
    );
  }

  /// `Active chat exists`
  String get activeChatExists {
    return Intl.message(
      'Active chat exists',
      name: 'activeChatExists',
      desc: '',
      args: [],
    );
  }

  /// `View Offers`
  String get viewOffers {
    return Intl.message('View Offers', name: 'viewOffers', desc: '', args: []);
  }

  /// `Ongoing Requests`
  String get ongoingRequests {
    return Intl.message(
      'Ongoing Requests',
      name: 'ongoingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Track Request`
  String get trackRequest {
    return Intl.message(
      'Track Request',
      name: 'trackRequest',
      desc: '',
      args: [],
    );
  }

  /// `Find nearby maintenance centers`
  String get findNearbyCenters {
    return Intl.message(
      'Find nearby maintenance centers',
      name: 'findNearbyCenters',
      desc: '',
      args: [],
    );
  }

  /// `Explore more than {count} centers near you`
  String exploreNearbyCentersCount(Object count) {
    return Intl.message(
      'Explore more than $count centers near you',
      name: 'exploreNearbyCentersCount',
      desc: '',
      args: [count],
    );
  }

  /// `Locating nearby centers...`
  String get locatingNearbyCenters {
    return Intl.message(
      'Locating nearby centers...',
      name: 'locatingNearbyCenters',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications1 {
    return Intl.message(
      'Notifications',
      name: 'notifications1',
      desc: '',
      args: [],
    );
  }

  /// `No notifications currently`
  String get noNotifications {
    return Intl.message(
      'No notifications currently',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Earlier`
  String get past {
    return Intl.message('Earlier', name: 'past', desc: '', args: []);
  }

  /// `My Offers`
  String get myOffers {
    return Intl.message('My Offers', name: 'myOffers', desc: '', args: []);
  }

  /// `Offer deleted successfully`
  String get deleteOfferSuccess {
    return Intl.message(
      'Offer deleted successfully',
      name: 'deleteOfferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No accepted offers currently`
  String get noAcceptedOffers {
    return Intl.message(
      'No accepted offers currently',
      name: 'noAcceptedOffers',
      desc: '',
      args: [],
    );
  }

  /// `No pending offers currently`
  String get noPendingOffers {
    return Intl.message(
      'No pending offers currently',
      name: 'noPendingOffers',
      desc: '',
      args: [],
    );
  }

  /// `No completed offers currently`
  String get noCompletedOffers {
    return Intl.message(
      'No completed offers currently',
      name: 'noCompletedOffers',
      desc: '',
      args: [],
    );
  }

  /// `No rejected offers currently`
  String get noRejectedOffers {
    return Intl.message(
      'No rejected offers currently',
      name: 'noRejectedOffers',
      desc: '',
      args: [],
    );
  }

  /// `No submitted offers currently`
  String get noSubmittedOffers {
    return Intl.message(
      'No submitted offers currently',
      name: 'noSubmittedOffers',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message('Accepted', name: 'accepted', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `PM`
  String get pm {
    return Intl.message('PM', name: 'pm', desc: '', args: []);
  }

  /// `AM`
  String get am {
    return Intl.message('AM', name: 'am', desc: '', args: []);
  }

  /// `Help Type`
  String get helpType {
    return Intl.message('Help Type', name: 'helpType', desc: '', args: []);
  }

  /// `Offline Help`
  String get fieldHelp {
    return Intl.message('Offline Help', name: 'fieldHelp', desc: '', args: []);
  }

  /// `Date & Time`
  String get dateTime {
    return Intl.message('Date & Time', name: 'dateTime', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Attached Images`
  String get attachedImages {
    return Intl.message(
      'Attached Images',
      name: 'attachedImages',
      desc: '',
      args: [],
    );
  }

  /// `{count} images`
  String imagesCount(Object count) {
    return Intl.message(
      '$count images',
      name: 'imagesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Request cancelled successfully`
  String get requestCancelledSuccessfully {
    return Intl.message(
      'Request cancelled successfully',
      name: 'requestCancelledSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Help offer submitted successfully`
  String get helpOfferSubmittedSuccessfully {
    return Intl.message(
      'Help offer submitted successfully',
      name: 'helpOfferSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sending offer...`
  String get sendingOffer {
    return Intl.message(
      'Sending offer...',
      name: 'sendingOffer',
      desc: '',
      args: [],
    );
  }

  /// `Provide Help`
  String get provideHelp {
    return Intl.message(
      'Provide Help',
      name: 'provideHelp',
      desc: '',
      args: [],
    );
  }

  /// `Battery`
  String get battery {
    return Intl.message('Battery', name: 'battery', desc: '', args: []);
  }

  /// `Engine`
  String get engine {
    return Intl.message('Engine', name: 'engine', desc: '', args: []);
  }

  /// `Tires`
  String get tires {
    return Intl.message('Tires', name: 'tires', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `You want to request help directly on the road`
  String get roadsideHelpDesc {
    return Intl.message(
      'You want to request help directly on the road',
      name: 'roadsideHelpDesc',
      desc: '',
      args: [],
    );
  }

  /// `Request Help`
  String get requestHelpButton {
    return Intl.message(
      'Request Help',
      name: 'requestHelpButton',
      desc: '',
      args: [],
    );
  }

  /// `You want online help via chat`
  String get onlineChatHelpDesc {
    return Intl.message(
      'You want online help via chat',
      name: 'onlineChatHelpDesc',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading data`
  String get errorLoadingData {
    return Intl.message(
      'An error occurred while loading data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `Offer status updated successfully`
  String get offerStatusUpdated {
    return Intl.message(
      'Offer status updated successfully',
      name: 'offerStatusUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled successfully`
  String get requestCancelled {
    return Intl.message(
      'Request cancelled successfully',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Chat created successfully`
  String get chatCreated {
    return Intl.message(
      'Chat created successfully',
      name: 'chatCreated',
      desc: '',
      args: [],
    );
  }

  /// `View Request Details`
  String get viewRequestDetails {
    return Intl.message(
      'View Request Details',
      name: 'viewRequestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Request`
  String get cancelRequest {
    return Intl.message(
      'Cancel Request',
      name: 'cancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Available Offers`
  String get availableOffers {
    return Intl.message(
      'Available Offers',
      name: 'availableOffers',
      desc: '',
      args: [],
    );
  }

  /// `No offers available`
  String get noOffers {
    return Intl.message(
      'No offers available',
      name: 'noOffers',
      desc: '',
      args: [],
    );
  }

  /// `Receiving available offers...`
  String get receivingOffers {
    return Intl.message(
      'Receiving available offers...',
      name: 'receivingOffers',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Time`
  String get arrivalTime {
    return Intl.message(
      'Arrival Time',
      name: 'arrivalTime',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} min`
  String minutesDuration(Object minutes) {
    return Intl.message(
      '$minutes min',
      name: 'minutesDuration',
      desc: '',
      args: [minutes],
    );
  }

  /// `Distance`
  String get distanceLabel {
    return Intl.message('Distance', name: 'distanceLabel', desc: '', args: []);
  }

  /// `{distance} km`
  String distanceKm(Object distance) {
    return Intl.message(
      '$distance km',
      name: 'distanceKm',
      desc: '',
      args: [distance],
    );
  }

  /// `Offer Accepted`
  String get offerAccepted {
    return Intl.message(
      'Offer Accepted',
      name: 'offerAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Start documenting your car's maintenance journey to alert you of upcoming appointments.`
  String get startDocumentingJourney {
    return Intl.message(
      'Start documenting your car\'s maintenance journey to alert you of upcoming appointments.',
      name: 'startDocumentingJourney',
      desc: '',
      args: [],
    );
  }

  /// `Add Maintenance History`
  String get addMaintenanceHistory {
    return Intl.message(
      'Add Maintenance History',
      name: 'addMaintenanceHistory',
      desc: '',
      args: [],
    );
  }

  /// `Last Maintenance`
  String get lastMaintenance {
    return Intl.message(
      'Last Maintenance',
      name: 'lastMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `No history`
  String get noHistory {
    return Intl.message('No history', name: 'noHistory', desc: '', args: []);
  }

  /// `Total Payment`
  String get totalPayment {
    return Intl.message(
      'Total Payment',
      name: 'totalPayment',
      desc: '',
      args: [],
    );
  }

  /// `{cost} EGP`
  String egpCurrency(Object cost) {
    return Intl.message(
      '$cost EGP',
      name: 'egpCurrency',
      desc: '',
      args: [cost],
    );
  }

  /// `New Maintenance Record`
  String get newMaintenanceRecord {
    return Intl.message(
      'New Maintenance Record',
      name: 'newMaintenanceRecord',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateLabel {
    return Intl.message('Date', name: 'dateLabel', desc: '', args: []);
  }

  /// `Maintenance Center`
  String get maintenanceCenter {
    return Intl.message(
      'Maintenance Center',
      name: 'maintenanceCenter',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Type`
  String get maintenanceType {
    return Intl.message(
      'Maintenance Type',
      name: 'maintenanceType',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionLabel {
    return Intl.message(
      'Description',
      name: 'descriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cost (EGP)`
  String get costEgp {
    return Intl.message('Cost (EGP)', name: 'costEgp', desc: '', args: []);
  }

  /// `Saving...`
  String get saving {
    return Intl.message('Saving...', name: 'saving', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `{service} was performed to resolve the issue`
  String maintenanceDoneReason(Object service) {
    return Intl.message(
      '$service was performed to resolve the issue',
      name: 'maintenanceDoneReason',
      desc: '',
      args: [service],
    );
  }

  /// `Search for a problem or service center...`
  String get mapSearchHint {
    return Intl.message(
      'Search for a problem or service center...',
      name: 'mapSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Fetching your location, please wait...`
  String get fetchingLocation {
    return Intl.message(
      'Fetching your location, please wait...',
      name: 'fetchingLocation',
      desc: '',
      args: [],
    );
  }

  /// `No service centers found nearby`
  String get noServiceCentersFound {
    return Intl.message(
      'No service centers found nearby',
      name: 'noServiceCentersFound',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingNamePlaceholder {
    return Intl.message(
      'Loading...',
      name: 'loadingNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get km {
    return Intl.message('km', name: 'km', desc: '', args: []);
  }

  /// `Directions`
  String get directions {
    return Intl.message('Directions', name: 'directions', desc: '', args: []);
  }

  /// `Smart Diagnosis`
  String get smartDiagnosis2 {
    return Intl.message(
      'Smart Diagnosis',
      name: 'smartDiagnosis2',
      desc: '',
      args: [],
    );
  }

  /// `Choose the most appropriate method to analyze the car problem`
  String get chooseDiagnosisMethod {
    return Intl.message(
      'Choose the most appropriate method to analyze the car problem',
      name: 'chooseDiagnosisMethod',
      desc: '',
      args: [],
    );
  }

  /// `No diagnostics found for this code.`
  String get noDiagnosticsFound {
    return Intl.message(
      'No diagnostics found for this code.',
      name: 'noDiagnosticsFound',
      desc: '',
      args: [],
    );
  }

  /// `Explain the Problem`
  String get explainProblem {
    return Intl.message(
      'Explain the Problem',
      name: 'explainProblem',
      desc: '',
      args: [],
    );
  }

  /// `OBD Diagnosis`
  String get obdDiagnosis {
    return Intl.message(
      'OBD Diagnosis',
      name: 'obdDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis Summary:`
  String get diagnosisSummary {
    return Intl.message(
      'Diagnosis Summary:',
      name: 'diagnosisSummary',
      desc: '',
      args: [],
    );
  }

  /// `Severity Level: `
  String get severityLevelLabel {
    return Intl.message(
      'Severity Level: ',
      name: 'severityLevelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Can you drive: `
  String get canDriveLabel {
    return Intl.message(
      'Can you drive: ',
      name: 'canDriveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Possible Causes: `
  String get possibleCausesLabel {
    return Intl.message(
      'Possible Causes: ',
      name: 'possibleCausesLabel',
      desc: '',
      args: [],
    );
  }

  /// `What to check: `
  String get whatToCheckLabel {
    return Intl.message(
      'What to check: ',
      name: 'whatToCheckLabel',
      desc: '',
      args: [],
    );
  }

  /// `Can you check the problem at home? `
  String get canCheckAtHomeLabel {
    return Intl.message(
      'Can you check the problem at home? ',
      name: 'canCheckAtHomeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Technical Recommendation: `
  String get technicalRecommendationLabel {
    return Intl.message(
      'Technical Recommendation: ',
      name: 'technicalRecommendationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Output Language: `
  String get outputLanguage {
    return Intl.message(
      'Output Language: ',
      name: 'outputLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Car Type and Model`
  String get carTypeAndModel {
    return Intl.message(
      'Car Type and Model',
      name: 'carTypeAndModel',
      desc: '',
      args: [],
    );
  }

  /// `Example: Mercedes C200 2021 or Toyota Corolla`
  String get carExampleHint {
    return Intl.message(
      'Example: Mercedes C200 2021 or Toyota Corolla',
      name: 'carExampleHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter car type and model`
  String get carValidationEmpty {
    return Intl.message(
      'Please enter car type and model',
      name: 'carValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `OBD Code`
  String get obdCodeLabel {
    return Intl.message('OBD Code', name: 'obdCodeLabel', desc: '', args: []);
  }

  /// `P0420`
  String get obdCodeHint {
    return Intl.message('P0420', name: 'obdCodeHint', desc: '', args: []);
  }

  /// `Please enter OBD code first`
  String get obdCodeValidationEmpty {
    return Intl.message(
      'Please enter OBD code first',
      name: 'obdCodeValidationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Live Sensor Data: `
  String get liveSensorData {
    return Intl.message(
      'Live Sensor Data: ',
      name: 'liveSensorData',
      desc: '',
      args: [],
    );
  }

  /// `Engine Coolant Temp`
  String get engineCoolant {
    return Intl.message(
      'Engine Coolant Temp',
      name: 'engineCoolant',
      desc: '',
      args: [],
    );
  }

  /// `Engine RPM`
  String get engineRpm {
    return Intl.message('Engine RPM', name: 'engineRpm', desc: '', args: []);
  }

  /// `Engine Load`
  String get engineLoad {
    return Intl.message('Engine Load', name: 'engineLoad', desc: '', args: []);
  }

  /// `Vehicle Speed`
  String get carSpeed {
    return Intl.message('Vehicle Speed', name: 'carSpeed', desc: '', args: []);
  }

  /// `Throttle Position`
  String get throttlePosition {
    return Intl.message(
      'Throttle Position',
      name: 'throttlePosition',
      desc: '',
      args: [],
    );
  }

  /// `Numbers only`
  String get numbersOnly {
    return Intl.message(
      'Numbers only',
      name: 'numbersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Analyze Code & Data`
  String get analyzeCodeAndData {
    return Intl.message(
      'Analyze Code & Data',
      name: 'analyzeCodeAndData',
      desc: '',
      args: [],
    );
  }

  /// `Please correct the errors in red fields first.`
  String get fixErrorsSnackbar {
    return Intl.message(
      'Please correct the errors in red fields first.',
      name: 'fixErrorsSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `OBD Trouble Code Analysis`
  String get obdAnalysisTitle {
    return Intl.message(
      'OBD Trouble Code Analysis',
      name: 'obdAnalysisTitle',
      desc: '',
      args: [],
    );
  }

  /// `Understand car codes and discover technical problems accurately.`
  String get obdAnalysisSubTitle {
    return Intl.message(
      'Understand car codes and discover technical problems accurately.',
      name: 'obdAnalysisSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `AI Smart Diagnosis`
  String get aiSmartDiagnosis {
    return Intl.message(
      'AI Smart Diagnosis',
      name: 'aiSmartDiagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Analyze car problems by describing symptoms to provide smart suggestions and diagnostics.`
  String get aiDiagnosisSubTitle {
    return Intl.message(
      'Analyze car problems by describing symptoms to provide smart suggestions and diagnostics.',
      name: 'aiDiagnosisSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Example: There is a strange sound when braking in the front wheels...`
  String get problemDescriptionHint {
    return Intl.message(
      'Example: There is a strange sound when braking in the front wheels...',
      name: 'problemDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `The diagnosis is advisory and not a substitute for a technical inspection.`
  String get disclaimerText {
    return Intl.message(
      'The diagnosis is advisory and not a substitute for a technical inspection.',
      name: 'disclaimerText',
      desc: '',
      args: [],
    );
  }

  /// `Analyze Problem`
  String get analyzeProblemButton {
    return Intl.message(
      'Analyze Problem',
      name: 'analyzeProblemButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description of the problem first before analyzing.`
  String get emptyProblemSnackbar {
    return Intl.message(
      'Please enter a description of the problem first before analyzing.',
      name: 'emptyProblemSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading requests`
  String get loadRequestsError {
    return Intl.message(
      'An error occurred while loading requests',
      name: 'loadRequestsError',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No requests available`
  String get noRequestsAvailable {
    return Intl.message(
      'No requests available',
      name: 'noRequestsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message('Welcome to', name: 'welcomeTo', desc: '', args: []);
  }

  /// `How would you like to participate today?\nHelping others or getting support`
  String get motoverseCommunitySub {
    return Intl.message(
      'How would you like to participate today?\nHelping others or getting support',
      name: 'motoverseCommunitySub',
      desc: '',
      args: [],
    );
  }

  /// `Want to request roadside assistance or consult others about your car problem`
  String get requestHelpDesc {
    return Intl.message(
      'Want to request roadside assistance or consult others about your car problem',
      name: 'requestHelpDesc',
      desc: '',
      args: [],
    );
  }

  /// `Request Help`
  String get requestHelpBtn {
    return Intl.message(
      'Request Help',
      name: 'requestHelpBtn',
      desc: '',
      args: [],
    );
  }

  /// `Browse assistance requests near you and share your experience with people in need`
  String get viewRequestsDesc {
    return Intl.message(
      'Browse assistance requests near you and share your experience with people in need',
      name: 'viewRequestsDesc',
      desc: '',
      args: [],
    );
  }

  /// `View Current Requests`
  String get viewRequestsBtn {
    return Intl.message(
      'View Current Requests',
      name: 'viewRequestsBtn',
      desc: '',
      args: [],
    );
  }

  /// `Problem Type`
  String get problemType {
    return Intl.message(
      'Problem Type',
      name: 'problemType',
      desc: '',
      args: [],
    );
  }

  /// `Problem Description`
  String get problemDescription {
    return Intl.message(
      'Problem Description',
      name: 'problemDescription',
      desc: '',
      args: [],
    );
  }

  /// `Describe the problem you are facing`
  String get describeYourProblemHint {
    return Intl.message(
      'Describe the problem you are facing',
      name: 'describeYourProblemHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get addImages {
    return Intl.message('Add Images', name: 'addImages', desc: '', args: []);
  }

  /// `Your images and data are stored securely`
  String get dataStoredSecurely {
    return Intl.message(
      'Your images and data are stored securely',
      name: 'dataStoredSecurely',
      desc: '',
      args: [],
    );
  }

  /// `Request Sent Successfully`
  String get requestSentSuccessfully {
    return Intl.message(
      'Request Sent Successfully',
      name: 'requestSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been received successfully\nand will be displayed in the request log`
  String get requestReceivedDesc {
    return Intl.message(
      'Your request has been received successfully\nand will be displayed in the request log',
      name: 'requestReceivedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please select a problem type`
  String get selectProblemTypeValidation {
    return Intl.message(
      'Please select a problem type',
      name: 'selectProblemTypeValidation',
      desc: '',
      args: [],
    );
  }

  /// `This offer has been canceled`
  String get offerRejected {
    return Intl.message(
      'This offer has been canceled',
      name: 'offerRejected',
      desc: '',
      args: [],
    );
  }

  /// `This offer has been completed`
  String get offerCompleted {
    return Intl.message(
      'This offer has been completed',
      name: 'offerCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancel help offer`
  String get cancelHelpOffer {
    return Intl.message(
      'Cancel help offer',
      name: 'cancelHelpOffer',
      desc: '',
      args: [],
    );
  }

  /// `Offline Help`
  String get offlineHelp {
    return Intl.message(
      'Offline Help',
      name: 'offlineHelp',
      desc: '',
      args: [],
    );
  }

  /// `Online Help`
  String get onlineHelp {
    return Intl.message('Online Help', name: 'onlineHelp', desc: '', args: []);
  }

  /// `All customer details and personal data are protected and secured.`
  String get dataProtectionNotice {
    return Intl.message(
      'All customer details and personal data are protected and secured.',
      name: 'dataProtectionNotice',
      desc: '',
      args: [],
    );
  }

  /// `You can select up to 3 traits only`
  String get maxTagsWarning {
    return Intl.message(
      'You can select up to 3 traits only',
      name: 'maxTagsWarning',
      desc: '',
      args: [],
    );
  }

  /// `Your review has been submitted successfully!`
  String get reviewSubmittedSuccessfully {
    return Intl.message(
      'Your review has been submitted successfully!',
      name: 'reviewSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The order has been completed successfully`
  String get orderCompletedSuccessfully {
    return Intl.message(
      'The order has been completed successfully',
      name: 'orderCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `How was your experience with the helper?`
  String get experienceQuestion {
    return Intl.message(
      'How was your experience with the helper?',
      name: 'experienceQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment`
  String get addComment {
    return Intl.message(
      'Add a comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Share your experience to help other users`
  String get commentHint {
    return Intl.message(
      'Share your experience to help other users',
      name: 'commentHint',
      desc: '',
      args: [],
    );
  }

  /// `Submitting...`
  String get submitting {
    return Intl.message(
      'Submitting...',
      name: 'submitting',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get submitReview {
    return Intl.message(
      'Submit Review',
      name: 'submitReview',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Your request is secured and backed by Motoverse Safety guarantee.`
  String get safetyNotice {
    return Intl.message(
      'Your request is secured and backed by Motoverse Safety guarantee.',
      name: 'safetyNotice',
      desc: '',
      args: [],
    );
  }

  /// `Fast Response`
  String get fastResponse {
    return Intl.message(
      'Fast Response',
      name: 'fastResponse',
      desc: '',
      args: [],
    );
  }

  /// `Excellent Manner`
  String get excellentManner {
    return Intl.message(
      'Excellent Manner',
      name: 'excellentManner',
      desc: '',
      args: [],
    );
  }

  /// `Professional`
  String get professional {
    return Intl.message(
      'Professional',
      name: 'professional',
      desc: '',
      args: [],
    );
  }

  /// `Helpful`
  String get helpful {
    return Intl.message('Helpful', name: 'helpful', desc: '', args: []);
  }

  /// `Needs Improvement`
  String get needsImprovement {
    return Intl.message(
      'Needs Improvement',
      name: 'needsImprovement',
      desc: '',
      args: [],
    );
  }

  /// `My Requests`
  String get myRequests {
    return Intl.message('My Requests', name: 'myRequests', desc: '', args: []);
  }

  /// `No active requests currently`
  String get noActiveRequests {
    return Intl.message(
      'No active requests currently',
      name: 'noActiveRequests',
      desc: '',
      args: [],
    );
  }

  /// `No previous requests`
  String get noPreviousRequests {
    return Intl.message(
      'No previous requests',
      name: 'noPreviousRequests',
      desc: '',
      args: [],
    );
  }

  /// `You can create a new request or review previous requests.`
  String get emptyRequestsSubtitle {
    return Intl.message(
      'You can create a new request or review previous requests.',
      name: 'emptyRequestsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Car`
  String get car {
    return Intl.message('Car', name: 'car', desc: '', args: []);
  }

  /// `Reported Problem`
  String get reportedProblem {
    return Intl.message(
      'Reported Problem',
      name: 'reportedProblem',
      desc: '',
      args: [],
    );
  }

  /// `Malfunction in {problem}`
  String malfunctionIn(Object problem) {
    return Intl.message(
      'Malfunction in $problem',
      name: 'malfunctionIn',
      desc: '',
      args: [problem],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Chat Help`
  String get chatHelp {
    return Intl.message('Chat Help', name: 'chatHelp', desc: '', args: []);
  }

  /// `Offline Help`
  String get roadsideHelp {
    return Intl.message(
      'Offline Help',
      name: 'roadsideHelp',
      desc: '',
      args: [],
    );
  }

  /// `Helper`
  String get defaultHelperName {
    return Intl.message(
      'Helper',
      name: 'defaultHelperName',
      desc: '',
      args: [],
    );
  }

  /// `Current Rating: {rating}`
  String currentRating(Object rating) {
    return Intl.message(
      'Current Rating: $rating',
      name: 'currentRating',
      desc: '',
      args: [rating],
    );
  }

  /// `N/A`
  String get ratingNotAvailable {
    return Intl.message('N/A', name: 'ratingNotAvailable', desc: '', args: []);
  }

  /// `Locating your position, please wait...`
  String get locatingUserMessage {
    return Intl.message(
      'Locating your position, please wait...',
      name: 'locatingUserMessage',
      desc: '',
      args: [],
    );
  }

  /// `Find nearby maintenance centers`
  String get findNearbyCentersTitle {
    return Intl.message(
      'Find nearby maintenance centers',
      name: 'findNearbyCentersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore more than 24 centers`
  String get findNearbyCentersSubtitle {
    return Intl.message(
      'Explore more than 24 centers',
      name: 'findNearbyCentersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Problem Details`
  String get problemDetails {
    return Intl.message(
      'Problem Details',
      name: 'problemDetails',
      desc: '',
      args: [],
    );
  }

  /// `{distance} km away`
  String away(Object distance) {
    return Intl.message(
      '$distance km away',
      name: 'away',
      desc: '',
      args: [distance],
    );
  }

  /// `Distance and Time`
  String get distanceAndTime {
    return Intl.message(
      'Distance and Time',
      name: 'distanceAndTime',
      desc: '',
      args: [],
    );
  }

  /// `{distance} km - {minutes} min`
  String distanceAndMinutes(Object distance, Object minutes) {
    return Intl.message(
      '$distance km - $minutes min',
      name: 'distanceAndMinutes',
      desc: '',
      args: [distance, minutes],
    );
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Confirm Complete Request`
  String get confirmCompleteRequestTitle {
    return Intl.message(
      'Confirm Complete Request',
      name: 'confirmCompleteRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Once the request is completed, you will not be able to communicate with the other party through this chat. Are you sure you want to complete the request?`
  String get confirmCompleteRequestDesc {
    return Intl.message(
      'Once the request is completed, you will not be able to communicate with the other party through this chat. Are you sure you want to complete the request?',
      name: 'confirmCompleteRequestDesc',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Online`
  String get online {
    return Intl.message('Online', name: 'online', desc: '', args: []);
  }

  /// `Offline`
  String get offline {
    return Intl.message('Offline', name: 'offline', desc: '', args: []);
  }

  /// `No messages yet`
  String get noMessagesYet {
    return Intl.message(
      'No messages yet',
      name: 'noMessagesYet',
      desc: '',
      args: [],
    );
  }

  /// `Verified Helper`
  String get verifiedHelper {
    return Intl.message(
      'Verified Helper',
      name: 'verifiedHelper',
      desc: '',
      args: [],
    );
  }

  /// `End Chat`
  String get endChat {
    return Intl.message('End Chat', name: 'endChat', desc: '', args: []);
  }

  /// `Please enable microphone permission to record`
  String get microphonePermissionRequired {
    return Intl.message(
      'Please enable microphone permission to record',
      name: 'microphonePermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Attach an image`
  String get attachImageTooltip {
    return Intl.message(
      'Attach an image',
      name: 'attachImageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Type your message here...`
  String get typeMessageHint {
    return Intl.message(
      'Type your message here...',
      name: 'typeMessageHint',
      desc: '',
      args: [],
    );
  }

  /// `Cancel recording`
  String get cancelRecordingTooltip {
    return Intl.message(
      'Cancel recording',
      name: 'cancelRecordingTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Recording audio...`
  String get recordingVoice {
    return Intl.message(
      'Recording audio...',
      name: 'recordingVoice',
      desc: '',
      args: [],
    );
  }

  /// `Send recording`
  String get sendRecordingTooltip {
    return Intl.message(
      'Send recording',
      name: 'sendRecordingTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Member since {date}`
  String memberSince(Object date) {
    return Intl.message(
      'Member since $date',
      name: 'memberSince',
      desc: '',
      args: [date],
    );
  }

  /// `Activity Center`
  String get centerOfActivities {
    return Intl.message(
      'Activity Center',
      name: 'centerOfActivities',
      desc: '',
      args: [],
    );
  }

  /// `Security & Verification`
  String get securityAndVerification {
    return Intl.message(
      'Security & Verification',
      name: 'securityAndVerification',
      desc: '',
      args: [],
    );
  }

  /// `Identity Verification`
  String get identityVerification {
    return Intl.message(
      'Identity Verification',
      name: 'identityVerification',
      desc: '',
      args: [],
    );
  }

  /// `Incomplete`
  String get incomplete {
    return Intl.message('Incomplete', name: 'incomplete', desc: '', args: []);
  }

  /// `Privacy & Security`
  String get privacyAndSecurity {
    return Intl.message(
      'Privacy & Security',
      name: 'privacyAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
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

  /// `Location Settings`
  String get locationSettings {
    return Intl.message(
      'Location Settings',
      name: 'locationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Support & Assistance`
  String get supportAndAssistance {
    return Intl.message(
      'Support & Assistance',
      name: 'supportAndAssistance',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message('FAQ', name: 'faq', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Current Car`
  String get currentCar {
    return Intl.message('Current Car', name: 'currentCar', desc: '', args: []);
  }

  /// `No car registered`
  String get noCarRegistered {
    return Intl.message(
      'No car registered',
      name: 'noCarRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Plate Number: {plate}`
  String plateNumberLabel(Object plate) {
    return Intl.message(
      'Plate Number: $plate',
      name: 'plateNumberLabel',
      desc: '',
      args: [plate],
    );
  }

  /// `Car Information`
  String get carInformation {
    return Intl.message(
      'Car Information',
      name: 'carInformation',
      desc: '',
      args: [],
    );
  }

  /// `Car Brand`
  String get carBrand {
    return Intl.message('Car Brand', name: 'carBrand', desc: '', args: []);
  }

  /// `Toyota`
  String get toyotaHint {
    return Intl.message('Toyota', name: 'toyotaHint', desc: '', args: []);
  }

  /// `Car Model`
  String get carModel {
    return Intl.message('Car Model', name: 'carModel', desc: '', args: []);
  }

  /// `Camry`
  String get camryHint {
    return Intl.message('Camry', name: 'camryHint', desc: '', args: []);
  }

  /// `Manufacture Year`
  String get manufactureYear {
    return Intl.message(
      'Manufacture Year',
      name: 'manufactureYear',
      desc: '',
      args: [],
    );
  }

  /// `Plate Number`
  String get plateNumber {
    return Intl.message(
      'Plate Number',
      name: 'plateNumber',
      desc: '',
      args: [],
    );
  }

  /// `A B C 1234`
  String get plateHint {
    return Intl.message('A B C 1234', name: 'plateHint', desc: '', args: []);
  }

  /// `Car Color`
  String get carColor {
    return Intl.message('Car Color', name: 'carColor', desc: '', args: []);
  }

  /// `All your personal data is processed and stored securely in accordance with our privacy policy.`
  String get privacyNote {
    return Intl.message(
      'All your personal data is processed and stored securely in accordance with our privacy policy.',
      name: 'privacyNote',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Add Car`
  String get addCar {
    return Intl.message('Add Car', name: 'addCar', desc: '', args: []);
  }

  /// `Delete Car`
  String get deleteCar {
    return Intl.message('Delete Car', name: 'deleteCar', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm Delete`
  String get deleteConfirmationTitle {
    return Intl.message(
      'Confirm Delete',
      name: 'deleteConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this car?`
  String get deleteConfirmationDesc {
    return Intl.message(
      'Are you sure you want to delete this car?',
      name: 'deleteConfirmationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteBtn {
    return Intl.message('Delete', name: 'deleteBtn', desc: '', args: []);
  }

  /// `Car details updated successfully`
  String get carUpdatedSuccess {
    return Intl.message(
      'Car details updated successfully',
      name: 'carUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Car added successfully`
  String get carAddedSuccess {
    return Intl.message(
      'Car added successfully',
      name: 'carAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Edit Your Information`
  String get editProfileTitle {
    return Intl.message(
      'Edit Your Information',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profileImage {
    return Intl.message(
      'Profile Picture',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get galleryOption {
    return Intl.message(
      'Choose from Gallery',
      name: 'galleryOption',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get cameraOption {
    return Intl.message(
      'Take a Photo',
      name: 'cameraOption',
      desc: '',
      args: [],
    );
  }

  /// `Remove Current Image`
  String get removeImageOption {
    return Intl.message(
      'Remove Current Image',
      name: 'removeImageOption',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `All your personal data is processed and stored securely in accordance with our privacy policy`
  String get privacyNotice {
    return Intl.message(
      'All your personal data is processed and stored securely in accordance with our privacy policy',
      name: 'privacyNotice',
      desc: '',
      args: [],
    );
  }

  /// `Changes saved successfully`
  String get successMessage {
    return Intl.message(
      'Changes saved successfully',
      name: 'successMessage',
      desc: '',
      args: [],
    );
  }

  /// `Smart vision for your car's key indicators`
  String get smartVisionIndicators {
    return Intl.message(
      'Smart vision for your car\'s key indicators',
      name: 'smartVisionIndicators',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguageTitle {
    return Intl.message(
      'App Language',
      name: 'appLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabicLanguage {
    return Intl.message('Arabic', name: 'arabicLanguage', desc: '', args: []);
  }

  /// `English`
  String get englishLanguage {
    return Intl.message('English', name: 'englishLanguage', desc: '', args: []);
  }

  /// `Language changes will be applied immediately across all sections and services.`
  String get languageNoticeText {
    return Intl.message(
      'Language changes will be applied immediately across all sections and services.',
      name: 'languageNoticeText',
      desc: '',
      args: [],
    );
  }

  /// `Capture ID Card - Front Side`
  String get frontIdTitle {
    return Intl.message(
      'Capture ID Card - Front Side',
      name: 'frontIdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Capture ID Card - Back Side`
  String get backIdTitle {
    return Intl.message(
      'Capture ID Card - Back Side',
      name: 'backIdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Capture a Clear Selfie`
  String get faceImageTitle {
    return Intl.message(
      'Capture a Clear Selfie',
      name: 'faceImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `We need to verify your identity`
  String get weNeedToVerifyYourIdentity {
    return Intl.message(
      'We need to verify your identity',
      name: 'weNeedToVerifyYourIdentity',
      desc: '',
      args: [],
    );
  }

  /// `To provide a secure and trusted experience\n for motoverse users`
  String get verificationSubtitle {
    return Intl.message(
      'To provide a secure and trusted experience\n for motoverse users',
      name: 'verificationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Verify Identity`
  String get verifyIdentityButton {
    return Intl.message(
      'Verify Identity',
      name: 'verifyIdentityButton',
      desc: '',
      args: [],
    );
  }

  /// `Please upload all required images`
  String get pleaseUploadAllImages {
    return Intl.message(
      'Please upload all required images',
      name: 'pleaseUploadAllImages',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded successfully`
  String get uploadSuccess {
    return Intl.message(
      'Uploaded successfully',
      name: 'uploadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reupload`
  String get reupload {
    return Intl.message('Reupload', name: 'reupload', desc: '', args: []);
  }

  /// `Add Data File`
  String get addDataFile {
    return Intl.message(
      'Add Data File',
      name: 'addDataFile',
      desc: '',
      args: [],
    );
  }

  /// `Upload vehicle diagnostic files (CSV, JSON, XLSX)`
  String get uploadVehicleDiagnosticFiles {
    return Intl.message(
      'Upload vehicle diagnostic files (CSV, JSON, XLSX)',
      name: 'uploadVehicleDiagnosticFiles',
      desc: '',
      args: [],
    );
  }

  /// `File uploaded successfully`
  String get fileUploadedSuccessfully {
    return Intl.message(
      'File uploaded successfully',
      name: 'fileUploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Re-upload`
  String get reuploadFile {
    return Intl.message('Re-upload', name: 'reuploadFile', desc: '', args: []);
  }

  /// `Analyze Data`
  String get analyzeData {
    return Intl.message(
      'Analyze Data',
      name: 'analyzeData',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Engine Temperature`
  String get engineTemperature {
    return Intl.message(
      'Engine Temperature',
      name: 'engineTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Level`
  String get fuelLevel {
    return Intl.message('Fuel Level', name: 'fuelLevel', desc: '', args: []);
  }

  /// `Barometric Pressure`
  String get barometricPressure {
    return Intl.message(
      'Barometric Pressure',
      name: 'barometricPressure',
      desc: '',
      args: [],
    );
  }

  /// `Intake Air Temp`
  String get intakeAirTemperature {
    return Intl.message(
      'Intake Air Temp',
      name: 'intakeAirTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Engine Runtime`
  String get engineRuntime {
    return Intl.message(
      'Engine Runtime',
      name: 'engineRuntime',
      desc: '',
      args: [],
    );
  }

  /// `Car Data Analysis`
  String get carDataAnalysis {
    return Intl.message(
      'Car Data Analysis',
      name: 'carDataAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Fault Detected`
  String get faultDetected {
    return Intl.message(
      'Fault Detected',
      name: 'faultDetected',
      desc: '',
      args: [],
    );
  }

  /// `AI Analysis`
  String get aiAnalysis {
    return Intl.message('AI Analysis', name: 'aiAnalysis', desc: '', args: []);
  }

  /// `Needs Follow-up`
  String get statusNeedsFollowUp {
    return Intl.message(
      'Needs Follow-up',
      name: 'statusNeedsFollowUp',
      desc: '',
      args: [],
    );
  }

  /// `Anomaly Ratio: {ratio}%`
  String anomalyRatio(Object ratio) {
    return Intl.message(
      'Anomaly Ratio: $ratio%',
      name: 'anomalyRatio',
      desc: '',
      args: [ratio],
    );
  }

  /// `Model Confidence`
  String get modelConfidence {
    return Intl.message(
      'Model Confidence',
      name: 'modelConfidence',
      desc: '',
      args: [],
    );
  }

  /// `Smart and Secure Diagnosis\n Analyze the problem with AI\n with a trusted and protected experience.`
  String get onboarding1 {
    return Intl.message(
      'Smart and Secure Diagnosis\n Analyze the problem with AI\n with a trusted and protected experience.',
      name: 'onboarding1',
      desc: '',
      args: [],
    );
  }

  /// `Access Certified Maintenance Centers\n and helpers around your location.`
  String get onboarding2 {
    return Intl.message(
      'Access Certified Maintenance Centers\n and helpers around your location.',
      name: 'onboarding2',
      desc: '',
      args: [],
    );
  }

  /// `Track your car condition clearly\n and understand potential faults before making decisions.`
  String get onboarding3 {
    return Intl.message(
      'Track your car condition clearly\n and understand potential faults before making decisions.',
      name: 'onboarding3',
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
