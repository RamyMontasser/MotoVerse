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

  static String m0(ratio) => "Anomaly Ratio: ${ratio}%";

  static String m1(distance) => "${distance} km away";

  static String m2(rating) => "Current Rating: ${rating}";

  static String m3(distance, minutes) => "${distance} km - ${minutes} min";

  static String m4(distance) => "${distance} km";

  static String m5(cost) => "${cost} EGP";

  static String m6(count) => "Explore more than ${count} centers near you";

  static String m7(count) => "${count} images";

  static String m8(service, date) => "Last maintenance: ${service} – ${date}";

  static String m9(service) => "${service} was performed to resolve the issue";

  static String m10(problem) => "Malfunction in ${problem}";

  static String m11(date) => "Member since ${date}";

  static String m12(minutes) => "${minutes} min";

  static String m13(count) => "${count} centers near you";

  static String m14(number) => "We sent a verification code to\n${number}";

  static String m15(plate) => "Plate Number: ${plate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("Accept"),
    "accepted": MessageLookupByLibrary.simpleMessage("Accepted"),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "activeChatExists": MessageLookupByLibrary.simpleMessage(
      "Active chat exists",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCar": MessageLookupByLibrary.simpleMessage("Add Car"),
    "addComment": MessageLookupByLibrary.simpleMessage("Add a comment"),
    "addDataFile": MessageLookupByLibrary.simpleMessage("Add Data File"),
    "addImages": MessageLookupByLibrary.simpleMessage("Add Images"),
    "addMaintenanceHistory": MessageLookupByLibrary.simpleMessage(
      "Add Maintenance History",
    ),
    "addPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Add your phone number",
    ),
    "aiAnalysis": MessageLookupByLibrary.simpleMessage("AI Analysis"),
    "aiDiagnosisSubTitle": MessageLookupByLibrary.simpleMessage(
      "Analyze car problems by describing symptoms to provide smart suggestions and diagnostics.",
    ),
    "aiSmartDiagnosis": MessageLookupByLibrary.simpleMessage(
      "AI Smart Diagnosis",
    ),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "am": MessageLookupByLibrary.simpleMessage("AM"),
    "analyzeCodeAndData": MessageLookupByLibrary.simpleMessage(
      "Analyze Code & Data",
    ),
    "analyzeData": MessageLookupByLibrary.simpleMessage("Analyze Data"),
    "analyzeProblemButton": MessageLookupByLibrary.simpleMessage(
      "Analyze Problem",
    ),
    "anomalyRatio": m0,
    "appLanguage": MessageLookupByLibrary.simpleMessage("App Language"),
    "appLanguageTitle": MessageLookupByLibrary.simpleMessage("App Language"),
    "appName": MessageLookupByLibrary.simpleMessage("MotoServe"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "arabicLanguage": MessageLookupByLibrary.simpleMessage("Arabic"),
    "arrivalTime": MessageLookupByLibrary.simpleMessage("Arrival Time"),
    "attachImageTooltip": MessageLookupByLibrary.simpleMessage(
      "Attach an image",
    ),
    "attachedImages": MessageLookupByLibrary.simpleMessage("Attached Images"),
    "availableOffers": MessageLookupByLibrary.simpleMessage("Available Offers"),
    "away": m1,
    "backIdTitle": MessageLookupByLibrary.simpleMessage(
      "Capture ID Card - Back Side",
    ),
    "barometricPressure": MessageLookupByLibrary.simpleMessage(
      "Barometric Pressure",
    ),
    "battery": MessageLookupByLibrary.simpleMessage("Battery"),
    "call": MessageLookupByLibrary.simpleMessage("Call"),
    "cameraOption": MessageLookupByLibrary.simpleMessage("Take a Photo"),
    "camryHint": MessageLookupByLibrary.simpleMessage("Camry"),
    "canCheckAtHomeLabel": MessageLookupByLibrary.simpleMessage(
      "Can you check the problem at home? ",
    ),
    "canDriveLabel": MessageLookupByLibrary.simpleMessage("Can you drive: "),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelHelpOffer": MessageLookupByLibrary.simpleMessage(
      "Cancel help offer",
    ),
    "cancelRecordingTooltip": MessageLookupByLibrary.simpleMessage(
      "Cancel recording",
    ),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("Cancel Request"),
    "car": MessageLookupByLibrary.simpleMessage("Car"),
    "carAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Car added successfully",
    ),
    "carBrand": MessageLookupByLibrary.simpleMessage("Car Brand"),
    "carColor": MessageLookupByLibrary.simpleMessage("Car Color"),
    "carDataAnalysis": MessageLookupByLibrary.simpleMessage(
      "Car Data Analysis",
    ),
    "carExampleHint": MessageLookupByLibrary.simpleMessage(
      "Example: Mercedes C200 2021 or Toyota Corolla",
    ),
    "carInformation": MessageLookupByLibrary.simpleMessage("Car Information"),
    "carModel": MessageLookupByLibrary.simpleMessage("Car Model"),
    "carSpeed": MessageLookupByLibrary.simpleMessage("Vehicle Speed"),
    "carTypeAndModel": MessageLookupByLibrary.simpleMessage(
      "Car Type and Model",
    ),
    "carUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Car details updated successfully",
    ),
    "carValidationEmpty": MessageLookupByLibrary.simpleMessage(
      "Please enter car type and model",
    ),
    "centerOfActivities": MessageLookupByLibrary.simpleMessage(
      "Activity Center",
    ),
    "chat": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatCreated": MessageLookupByLibrary.simpleMessage(
      "Chat created successfully",
    ),
    "chatHelp": MessageLookupByLibrary.simpleMessage("Chat Help"),
    "chooseDiagnosisMethod": MessageLookupByLibrary.simpleMessage(
      "Choose the most appropriate method to analyze the car problem",
    ),
    "commentHint": MessageLookupByLibrary.simpleMessage(
      "Share your experience to help other users",
    ),
    "compare": MessageLookupByLibrary.simpleMessage("Compare"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirmCompleteRequestDesc": MessageLookupByLibrary.simpleMessage(
      "Once the request is completed, you will not be able to communicate with the other party through this chat. Are you sure you want to complete the request?",
    ),
    "confirmCompleteRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Complete Request",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Phone Number",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "costEgp": MessageLookupByLibrary.simpleMessage("Cost (EGP)"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createNewAccount": MessageLookupByLibrary.simpleMessage(
      "Create New Account",
    ),
    "createPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Create Password",
    ),
    "currentCar": MessageLookupByLibrary.simpleMessage("Current Car"),
    "currentRating": m2,
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "dataProtectionNotice": MessageLookupByLibrary.simpleMessage(
      "All customer details and personal data are protected and secured.",
    ),
    "dataStoredSecurely": MessageLookupByLibrary.simpleMessage(
      "Your images and data are stored securely",
    ),
    "dateLabel": MessageLookupByLibrary.simpleMessage("Date"),
    "dateTime": MessageLookupByLibrary.simpleMessage("Date & Time"),
    "defaultHelperName": MessageLookupByLibrary.simpleMessage("Helper"),
    "deleteBtn": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteCar": MessageLookupByLibrary.simpleMessage("Delete Car"),
    "deleteConfirmationDesc": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this car?",
    ),
    "deleteConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Delete",
    ),
    "deleteOfferSuccess": MessageLookupByLibrary.simpleMessage(
      "Offer deleted successfully",
    ),
    "describeYourProblemHint": MessageLookupByLibrary.simpleMessage(
      "Describe the problem you are facing",
    ),
    "descriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
    "details": MessageLookupByLibrary.simpleMessage("View Details"),
    "diagnosisSummary": MessageLookupByLibrary.simpleMessage(
      "Diagnosis Summary:",
    ),
    "directions": MessageLookupByLibrary.simpleMessage("Directions"),
    "disclaimerText": MessageLookupByLibrary.simpleMessage(
      "The diagnosis is advisory and not a substitute for a technical inspection.",
    ),
    "distanceAndMinutes": m3,
    "distanceAndTime": MessageLookupByLibrary.simpleMessage(
      "Distance and Time",
    ),
    "distanceKm": m4,
    "distanceLabel": MessageLookupByLibrary.simpleMessage("Distance"),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit Your Information",
    ),
    "egpCurrency": m5,
    "email": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emergencySupport": MessageLookupByLibrary.simpleMessage(
      "Emergency support",
    ),
    "emptyProblemSnackbar": MessageLookupByLibrary.simpleMessage(
      "Please enter a description of the problem first before analyzing.",
    ),
    "emptyRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
      "You can create a new request or review previous requests.",
    ),
    "endChat": MessageLookupByLibrary.simpleMessage("End Chat"),
    "engine": MessageLookupByLibrary.simpleMessage("Engine"),
    "engineCoolant": MessageLookupByLibrary.simpleMessage(
      "Engine Coolant Temp",
    ),
    "engineLoad": MessageLookupByLibrary.simpleMessage("Engine Load"),
    "engineRpm": MessageLookupByLibrary.simpleMessage("Engine RPM"),
    "engineRuntime": MessageLookupByLibrary.simpleMessage("Engine Runtime"),
    "engineTemperature": MessageLookupByLibrary.simpleMessage(
      "Engine Temperature",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "englishLanguage": MessageLookupByLibrary.simpleMessage("English"),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "errorLoadingData": MessageLookupByLibrary.simpleMessage(
      "An error occurred while loading data",
    ),
    "excellentManner": MessageLookupByLibrary.simpleMessage("Excellent Manner"),
    "experienceQuestion": MessageLookupByLibrary.simpleMessage(
      "How was your experience with the helper?",
    ),
    "explainProblem": MessageLookupByLibrary.simpleMessage(
      "Explain the Problem",
    ),
    "exploreNearbyCentersCount": m6,
    "faceImageTitle": MessageLookupByLibrary.simpleMessage(
      "Capture a Clear Selfie",
    ),
    "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
    "fastResponse": MessageLookupByLibrary.simpleMessage("Fast Response"),
    "faultDetected": MessageLookupByLibrary.simpleMessage("Fault Detected"),
    "fetchingLocation": MessageLookupByLibrary.simpleMessage(
      "Fetching your location, please wait...",
    ),
    "fieldHelp": MessageLookupByLibrary.simpleMessage("Offline Help"),
    "fileUploadedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "File uploaded successfully",
    ),
    "findNearbyCenters": MessageLookupByLibrary.simpleMessage(
      "Find nearby maintenance centers",
    ),
    "findNearbyCentersSubtitle": MessageLookupByLibrary.simpleMessage(
      "Explore more than 24 centers",
    ),
    "findNearbyCentersTitle": MessageLookupByLibrary.simpleMessage(
      "Find nearby maintenance centers",
    ),
    "fixErrorsSnackbar": MessageLookupByLibrary.simpleMessage(
      "Please correct the errors in red fields first.",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "frontIdTitle": MessageLookupByLibrary.simpleMessage(
      "Capture ID Card - Front Side",
    ),
    "fuelLevel": MessageLookupByLibrary.simpleMessage("Fuel Level"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "galleryOption": MessageLookupByLibrary.simpleMessage(
      "Choose from Gallery",
    ),
    "helpOfferSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Help offer submitted successfully",
    ),
    "helpType": MessageLookupByLibrary.simpleMessage("Help Type"),
    "helpful": MessageLookupByLibrary.simpleMessage("Helpful"),
    "homeSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search for a car, service, or center...",
    ),
    "identityVerification": MessageLookupByLibrary.simpleMessage(
      "Identity Verification",
    ),
    "imagesCount": m7,
    "incomplete": MessageLookupByLibrary.simpleMessage("Incomplete"),
    "intakeAirTemperature": MessageLookupByLibrary.simpleMessage(
      "Intake Air Temp",
    ),
    "km": MessageLookupByLibrary.simpleMessage("km"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageNoticeText": MessageLookupByLibrary.simpleMessage(
      "Language changes will be applied immediately across all sections and services.",
    ),
    "lastMaintenance": MessageLookupByLibrary.simpleMessage("Last Maintenance"),
    "lastMaintenanceDetails": m8,
    "liveSensorData": MessageLookupByLibrary.simpleMessage(
      "Live Sensor Data: ",
    ),
    "loadRequestsError": MessageLookupByLibrary.simpleMessage(
      "An error occurred while loading requests",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loadingNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Loading...",
    ),
    "loadingTechnicalData": MessageLookupByLibrary.simpleMessage(
      "Last maintenance: Loading current technical data...",
    ),
    "locatingNearbyCenters": MessageLookupByLibrary.simpleMessage(
      "Locating nearby centers...",
    ),
    "locatingUserMessage": MessageLookupByLibrary.simpleMessage(
      "Locating your position, please wait...",
    ),
    "locationSettings": MessageLookupByLibrary.simpleMessage(
      "Location Settings",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "maintenanceCenter": MessageLookupByLibrary.simpleMessage(
      "Maintenance Center",
    ),
    "maintenanceDoneReason": m9,
    "maintenanceHistory": MessageLookupByLibrary.simpleMessage(
      "Maintenance History",
    ),
    "maintenanceType": MessageLookupByLibrary.simpleMessage("Maintenance Type"),
    "malfunctionIn": m10,
    "manufactureYear": MessageLookupByLibrary.simpleMessage("Manufacture Year"),
    "mapSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search for a problem or service center...",
    ),
    "marketSearchHint": MessageLookupByLibrary.simpleMessage("Search about"),
    "maxTagsWarning": MessageLookupByLibrary.simpleMessage(
      "You can select up to 3 traits only",
    ),
    "memberSince": m11,
    "microphonePermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Please enable microphone permission to record",
    ),
    "minutesDuration": m12,
    "modelConfidence": MessageLookupByLibrary.simpleMessage("Model Confidence"),
    "motoverseCommunitySub": MessageLookupByLibrary.simpleMessage(
      "How would you like to participate today?\nHelping others or getting support",
    ),
    "myCurrentOffers": MessageLookupByLibrary.simpleMessage(
      "My Current Offers",
    ),
    "myOffers": MessageLookupByLibrary.simpleMessage("My Offers"),
    "myRequests": MessageLookupByLibrary.simpleMessage("My Requests"),
    "nearbyMaintenance": MessageLookupByLibrary.simpleMessage("Nearby Centers"),
    "nearestCentersCount": m13,
    "needsImprovement": MessageLookupByLibrary.simpleMessage(
      "Needs Improvement",
    ),
    "newAdvantage": MessageLookupByLibrary.simpleMessage("New Advantage"),
    "newMaintenanceRecord": MessageLookupByLibrary.simpleMessage(
      "New Maintenance Record",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noAcceptedOffers": MessageLookupByLibrary.simpleMessage(
      "No accepted offers currently",
    ),
    "noActiveRequests": MessageLookupByLibrary.simpleMessage(
      "No active requests currently",
    ),
    "noCarRegistered": MessageLookupByLibrary.simpleMessage(
      "No car registered",
    ),
    "noCompletedOffers": MessageLookupByLibrary.simpleMessage(
      "No completed offers currently",
    ),
    "noDiagnosticsFound": MessageLookupByLibrary.simpleMessage(
      "No diagnostics found for this code.",
    ),
    "noHistory": MessageLookupByLibrary.simpleMessage("No history"),
    "noMaintenanceHistory": MessageLookupByLibrary.simpleMessage(
      "No maintenance history yet",
    ),
    "noMessagesYet": MessageLookupByLibrary.simpleMessage("No messages yet"),
    "noNearbyCenters": MessageLookupByLibrary.simpleMessage(
      "No nearby centers currently",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No notifications currently",
    ),
    "noOffers": MessageLookupByLibrary.simpleMessage("No offers available"),
    "noPendingOffers": MessageLookupByLibrary.simpleMessage(
      "No pending offers currently",
    ),
    "noPreviousRequests": MessageLookupByLibrary.simpleMessage(
      "No previous requests",
    ),
    "noRejectedOffers": MessageLookupByLibrary.simpleMessage(
      "No rejected offers currently",
    ),
    "noRequestsAvailable": MessageLookupByLibrary.simpleMessage(
      "No requests available",
    ),
    "noServiceCentersFound": MessageLookupByLibrary.simpleMessage(
      "No service centers found nearby",
    ),
    "noSubmittedOffers": MessageLookupByLibrary.simpleMessage(
      "No submitted offers currently",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notifications1": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numbersOnly": MessageLookupByLibrary.simpleMessage("Numbers only"),
    "obdAnalysisSubTitle": MessageLookupByLibrary.simpleMessage(
      "Understand car codes and discover technical problems accurately.",
    ),
    "obdAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "OBD Trouble Code Analysis",
    ),
    "obdCodeHint": MessageLookupByLibrary.simpleMessage("P0420"),
    "obdCodeLabel": MessageLookupByLibrary.simpleMessage("OBD Code"),
    "obdCodeValidationEmpty": MessageLookupByLibrary.simpleMessage(
      "Please enter OBD code first",
    ),
    "obdDiagnosis": MessageLookupByLibrary.simpleMessage("OBD Diagnosis"),
    "offerAccepted": MessageLookupByLibrary.simpleMessage("Offer Accepted"),
    "offerCompleted": MessageLookupByLibrary.simpleMessage(
      "This offer has been completed",
    ),
    "offerRejected": MessageLookupByLibrary.simpleMessage(
      "This offer has been canceled",
    ),
    "offerStatusUpdated": MessageLookupByLibrary.simpleMessage(
      "Offer status updated successfully",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offlineHelp": MessageLookupByLibrary.simpleMessage("Offline Help"),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Smart and Secure Diagnosis\n Analyze the problem with AI\n with a trusted and protected experience.",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Access Certified Maintenance Centers\n and helpers around your location.",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Track your car condition clearly\n and understand potential faults before making decisions.",
    ),
    "ongoingRequests": MessageLookupByLibrary.simpleMessage("Ongoing Requests"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "onlineChatHelpDesc": MessageLookupByLibrary.simpleMessage(
      "You want online help via chat",
    ),
    "onlineHelp": MessageLookupByLibrary.simpleMessage("Online Help"),
    "orderCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "The order has been completed successfully",
    ),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otpSentMessage": m14,
    "outputLanguage": MessageLookupByLibrary.simpleMessage("Output Language: "),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "past": MessageLookupByLibrary.simpleMessage("Earlier"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "plateHint": MessageLookupByLibrary.simpleMessage("A B C 1234"),
    "plateNumber": MessageLookupByLibrary.simpleMessage("Plate Number"),
    "plateNumberLabel": m15,
    "pleaseUploadAllImages": MessageLookupByLibrary.simpleMessage(
      "Please upload all required images",
    ),
    "pm": MessageLookupByLibrary.simpleMessage("PM"),
    "possibleCausesLabel": MessageLookupByLibrary.simpleMessage(
      "Possible Causes: ",
    ),
    "privacyAndSecurity": MessageLookupByLibrary.simpleMessage(
      "Privacy & Security",
    ),
    "privacyNote": MessageLookupByLibrary.simpleMessage(
      "All your personal data is processed and stored securely in accordance with our privacy policy.",
    ),
    "privacyNotice": MessageLookupByLibrary.simpleMessage(
      "All your personal data is processed and stored securely in accordance with our privacy policy",
    ),
    "problemDescription": MessageLookupByLibrary.simpleMessage(
      "Problem Description",
    ),
    "problemDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Example: There is a strange sound when braking in the front wheels...",
    ),
    "problemDetails": MessageLookupByLibrary.simpleMessage("Problem Details"),
    "problemType": MessageLookupByLibrary.simpleMessage("Problem Type"),
    "professional": MessageLookupByLibrary.simpleMessage("Professional"),
    "profileImage": MessageLookupByLibrary.simpleMessage("Profile Picture"),
    "provideHelp": MessageLookupByLibrary.simpleMessage("Provide Help"),
    "quickServices": MessageLookupByLibrary.simpleMessage("Quick Services"),
    "ratingNotAvailable": MessageLookupByLibrary.simpleMessage("N/A"),
    "receivingOffers": MessageLookupByLibrary.simpleMessage(
      "Receiving available offers...",
    ),
    "recordingVoice": MessageLookupByLibrary.simpleMessage(
      "Recording audio...",
    ),
    "reject": MessageLookupByLibrary.simpleMessage("Reject"),
    "rejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "removeImageOption": MessageLookupByLibrary.simpleMessage(
      "Remove Current Image",
    ),
    "reportedProblem": MessageLookupByLibrary.simpleMessage("Reported Problem"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "Request cancelled successfully",
    ),
    "requestCancelledSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Request cancelled successfully",
    ),
    "requestHelp": MessageLookupByLibrary.simpleMessage("Request Help"),
    "requestHelpBtn": MessageLookupByLibrary.simpleMessage("Request Help"),
    "requestHelpButton": MessageLookupByLibrary.simpleMessage("Request Help"),
    "requestHelpDesc": MessageLookupByLibrary.simpleMessage(
      "Want to request roadside assistance or consult others about your car problem",
    ),
    "requestReceivedDesc": MessageLookupByLibrary.simpleMessage(
      "Your request has been received successfully\nand will be displayed in the request log",
    ),
    "requestSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Request Sent Successfully",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "restorePassword": MessageLookupByLibrary.simpleMessage("Restore Password"),
    "restorePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number to restore password",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reupload": MessageLookupByLibrary.simpleMessage("Reupload"),
    "reuploadFile": MessageLookupByLibrary.simpleMessage("Re-upload"),
    "reviewSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your review has been submitted successfully!",
    ),
    "roadsideHelp": MessageLookupByLibrary.simpleMessage("Offline Help"),
    "roadsideHelpDesc": MessageLookupByLibrary.simpleMessage(
      "You want to request help directly on the road",
    ),
    "safetyNotice": MessageLookupByLibrary.simpleMessage(
      "Your request is secured and backed by Motoverse Safety guarantee.",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "saving": MessageLookupByLibrary.simpleMessage("Saving..."),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchCountry": MessageLookupByLibrary.simpleMessage("Search Country"),
    "securityAndVerification": MessageLookupByLibrary.simpleMessage(
      "Security & Verification",
    ),
    "selectCountry": MessageLookupByLibrary.simpleMessage("Select Country"),
    "selectProblemTypeValidation": MessageLookupByLibrary.simpleMessage(
      "Please select a problem type",
    ),
    "sendRecordingTooltip": MessageLookupByLibrary.simpleMessage(
      "Send recording",
    ),
    "sendingOffer": MessageLookupByLibrary.simpleMessage("Sending offer..."),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "severityLevelLabel": MessageLookupByLibrary.simpleMessage(
      "Severity Level: ",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "smartDiagnosis": MessageLookupByLibrary.simpleMessage(
      "Smart diagnosis of faults",
    ),
    "smartDiagnosis2": MessageLookupByLibrary.simpleMessage("Smart Diagnosis"),
    "smartDiagnosisSubtitle": MessageLookupByLibrary.simpleMessage(
      "Understand your car\'s problem through AI-based analysis.",
    ),
    "smartVisionIndicators": MessageLookupByLibrary.simpleMessage(
      "Smart vision for your car\'s key indicators",
    ),
    "startDiagnosis": MessageLookupByLibrary.simpleMessage("Start Diagnosis"),
    "startDocumentingJourney": MessageLookupByLibrary.simpleMessage(
      "Start documenting your car\'s maintenance journey to alert you of upcoming appointments.",
    ),
    "startJourney": MessageLookupByLibrary.simpleMessage("Start Your Journey"),
    "statusNeedsFollowUp": MessageLookupByLibrary.simpleMessage(
      "Needs Follow-up",
    ),
    "submitReview": MessageLookupByLibrary.simpleMessage("Submit Review"),
    "submitting": MessageLookupByLibrary.simpleMessage("Submitting..."),
    "successMessage": MessageLookupByLibrary.simpleMessage(
      "Changes saved successfully",
    ),
    "supportAndAssistance": MessageLookupByLibrary.simpleMessage(
      "Support & Assistance",
    ),
    "technicalRecommendationLabel": MessageLookupByLibrary.simpleMessage(
      "Technical Recommendation: ",
    ),
    "termsLink": MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
    "termsText": MessageLookupByLibrary.simpleMessage(
      "By creating an account, you agree to our ",
    ),
    "throttlePosition": MessageLookupByLibrary.simpleMessage(
      "Throttle Position",
    ),
    "tires": MessageLookupByLibrary.simpleMessage("Tires"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "totalPayment": MessageLookupByLibrary.simpleMessage("Total Payment"),
    "toyotaHint": MessageLookupByLibrary.simpleMessage("Toyota"),
    "trackRequest": MessageLookupByLibrary.simpleMessage("Track Request"),
    "typeMessageHint": MessageLookupByLibrary.simpleMessage(
      "Type your message here...",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "uploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Uploaded successfully",
    ),
    "uploadVehicleDiagnosticFiles": MessageLookupByLibrary.simpleMessage(
      "Upload vehicle diagnostic files (CSV, JSON, XLSX)",
    ),
    "vehicleSpeed": MessageLookupByLibrary.simpleMessage("Vehicle Speed"),
    "verificationSubtitle": MessageLookupByLibrary.simpleMessage(
      "To provide a secure and trusted experience\n for motoverse users",
    ),
    "verifiedHelper": MessageLookupByLibrary.simpleMessage("Verified Helper"),
    "verifyIdentityButton": MessageLookupByLibrary.simpleMessage(
      "Verify Identity",
    ),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewOffers": MessageLookupByLibrary.simpleMessage("View Offers"),
    "viewRequestDetails": MessageLookupByLibrary.simpleMessage(
      "View Request Details",
    ),
    "viewRequestsBtn": MessageLookupByLibrary.simpleMessage(
      "View Current Requests",
    ),
    "viewRequestsDesc": MessageLookupByLibrary.simpleMessage(
      "Browse assistance requests near you and share your experience with people in need",
    ),
    "weNeedToVerifyYourIdentity": MessageLookupByLibrary.simpleMessage(
      "We need to verify your identity",
    ),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Welcome back! Login to your account or ",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome"),
    "welcomeTo": MessageLookupByLibrary.simpleMessage("Welcome to"),
    "whatToCheckLabel": MessageLookupByLibrary.simpleMessage("What to check: "),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
  };
}
