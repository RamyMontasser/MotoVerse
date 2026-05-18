import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motoverse/Core/cache/app_pref.dart';
import 'package:motoverse/Core/providers/localization_provider.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/services/navigator_service.dart';
import 'package:motoverse/Core/services/secure_storage.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/ai_chat/presentation/views/ai_chat1.dart';
import 'package:motoverse/Features/ai_chat/presentation/views/ai_chat2.dart';
import 'package:motoverse/Features/auth/presentation/views/onboarding.dart';
import 'package:motoverse/Features/chat/presentation/views/chat_page.dart';
import 'package:motoverse/Features/auth/presentation/views/log_in.dart';
import 'package:motoverse/Features/auth/presentation/views/otp_forget.dart';
import 'package:motoverse/Features/auth/presentation/views/otp_page.dart';
import 'package:motoverse/Features/auth/presentation/views/phone_num.dart';
// import 'package:motoverse/Features/auth/presentation/views/onboarding.dart';
import 'package:motoverse/Features/auth/presentation/views/reset_pass.dart';
import 'package:motoverse/Features/auth/presentation/views/restore_pass.dart';
import 'package:motoverse/Features/auth/presentation/views/sign_up.dart';
import 'package:motoverse/Features/community/presentation/views/available_requists.dart';
import 'package:motoverse/Features/community/presentation/views/create_request.dart';
import 'package:motoverse/Features/community/presentation/views/help_offline.dart';
import 'package:motoverse/Features/settings/presentation/views/identity_varification1.dart';
import 'package:motoverse/Features/community/presentation/views/request_details.dart';
import 'package:motoverse/Features/community/presentation/views/request_help1.dart';
import 'package:motoverse/Features/community/presentation/views/requist_done.dart';
import 'package:motoverse/Features/community/presentation/views/user_requests_screen.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/domain/repo/map_repo.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/history/presentation/views/history_page1.dart';
import 'package:motoverse/Features/history/presentation/views/history_page2.dart';
import 'package:motoverse/Features/history/presentation/views/history_page3.dart';
import 'package:motoverse/Features/home/presentation/views/main_screen.dart';
import 'package:motoverse/Features/home/presentation/views/notification_page.dart';
import 'package:motoverse/Features/home/presentation/views/my_offers_page.dart';
// import 'package:motoverse/Features/home/presentation/views/map.dart';
// import 'package:motoverse/Features/home/presentation/views/market.dart';
import 'package:motoverse/Features/home/presentation/views/profile.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/settings/presentation/views/settings_screen.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/firebase_options.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  await AppPref.init();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataModelAdapter());
  await Hive.openBox<UserDataModel>('user_box');
  getitsetup();

  final secureStorage = getIt<SecureStorage>();
  final String? token = await secureStorage.getAccessToken();
  final bool isLoggedIn = token != null && token.isNotEmpty;

  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocalizationProvider()..init(),
        ),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        BlocProvider(
          create: (context) => CurrentLocationCubit(getIt<MapRepo>(), getIt<HomeRepo>()),
        ),
        BlocProvider(
          create: (context) => UserCubitCubit(homeRepo: getIt<HomeRepo>()),
        ),
        BlocProvider(
          create: (context) => RequestsCubit(communityRepo: getIt<CommunityRepo>()),
        ),
        BlocProvider(
          create: (context) => MyOffersCubit(getIt<HomeRepo>()),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // String lang = AppPref.getString(key: 'selectedLang') == 'English'
    //     ? 'en'
    //     : 'ar';
    // debugPrint(lang);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.textScaleFactorOf(context).clamp(1.0, 1.03),
            ),
          ),
          child: Consumer<LocalizationProvider>(
            builder: (context, LocalizationProvider, child) {
        return MaterialApp(
          navigatorKey: NavigatorService.navigatorKey,
                localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
                locale: Locale(LocalizationProvider.local),

          routes: {
            'phone number': (context) => PhoneNum(),
            'log in': (context) => LogIn(),
            'sign up': (context) => SignUp(),
            'restore pass': (context) => RestorePass(),
            'otp page': (context) => OtpPage(),
            'otp forget': (context) => OtpForget(),
            'reset pass': (context) => ResetPass(),
                  // 'home': (context) => Home(),
                  // 'tools': (context) => ToolsPage(),
                  // 'market': (context) => Market(),
                  // 'map': (context) => MapPage(),
            'profile': (context) => Profile(),
            'main screen': (context) => MainScreen(),
            'NotificationPage': (context) => NotificationPage(),
            'settings': (context) => Settings(),
            'history1': (context) => HistoryPage1(),
            'history2': (context) => HistoryPage2(),
            'history3': (context) => HistoryPage3(),
            'ai1': (context) => AiChat1(),
            'ai2': (context) => AiChat2(),
            'RequestHelp1': (context) => RequestHelp1(),
            'CreateRequest': (context) => CreateRequest(),
            'RequestDone': (context) => RequestDone(),
            'AvailableRequests': (context) => AvailableRequests(),
            'IdentityVarification': (context) => IdentityVarification(),
            'RequestDetails': (context) => RequestDetails(),
            'HelpOffline': (context) => HelpOffline(),
            'chat': (context) => ChatPage(),
            'UserRequests': (context) => const UserRequestsScreen(),
            'MyOffersPage': (context) => const MyOffersPage(),
          },

                debugShowCheckedModeBanner: false,
                title: 'MotoVerse',

                theme: ThemeData(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 10, 17),
                      foregroundColor: AppColors.whiteLight,
                    ),
                  ),
                  scaffoldBackgroundColor: AppColors.whiteLight,
                  
                ),

                home: 
                // ChatPage(),
                 isLoggedIn ? const MainScreen() : const OnBoarding(),
              );
          },
          ),
        );
      },
    );
  }
}
