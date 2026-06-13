import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/cache/app_pref.dart';
import 'package:motoverse/Core/providers/localization_provider.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/auth/presentation/cubit/logout_cubit.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/domain/repo/home_repo.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';
import 'package:motoverse/Features/profile/presentation/cubit/profile_car_cubit.dart';
import 'package:motoverse/Features/profile/presentation/widgets/car_analysis.dart';
import 'package:motoverse/Features/profile/presentation/widgets/current_car_card.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_avatar_widget.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_section.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_switch_item.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_user_info_widget.dart';
import 'package:motoverse/generated/l10n.dart'; 
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDataModel? currentUser;
  bool isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();

    final bool? saved = AppPref.getBool(key: 'notifications_enabled');
    if (saved != null) {
      isNotificationsEnabled = saved;
    } else {
      isNotificationsEnabled = true;
      AppPref.setBool(key: 'notifications_enabled', val: true);
    }

    _applyNotificationSetting(isNotificationsEnabled);
  }

  Future<void> _applyNotificationSetting(bool enabled) async {
    try {
      final homeRepo = getIt<HomeRepo>();
      if (enabled) {
        final messaging = FirebaseMessaging.instance;
        final settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          final token = await messaging.getToken();
          if (token != null) {
            await homeRepo.sendDeviceToken(token: token);
          }
        }
      } else {
        await FirebaseMessaging.instance.deleteToken();
        await homeRepo.sendDeviceToken(token: '');
      }
    } catch (e) {
      debugPrint('Error applying notification setting: $e');
    }
  }

  Future<void> _refreshProfile(BuildContext blocContext) async {
    await Future.wait([
      blocContext.read<ProfileCarCubit>().fetchCars(),
      blocContext.read<UserCubitCubit>().getUserInfo(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LogoutCubit(getIt<AuthRepo>())),
        BlocProvider(
          create: (_) =>
              ProfileCarCubit(profileCarRepo: getIt<ProfileCarRepo>())
                ..fetchCars(),
        ),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.read<NavigationProvider>().changeIndex(0);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('log in', (route) => false);
          }
          if (state is LogoutFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.msg)));
          }
        },
        child: Builder(
          builder: (innerContext) {
            return BlocBuilder<UserCubitCubit, UserCubitState>(
              builder: (context, state) {
                final userBox = Hive.box<UserDataModel>('user_box');
                currentUser = userBox.get('user');

                if (currentUser == null) {
                  if (state is GetUserInfoFailure) {
                    debugPrint(state.errMsg);
                    return Scaffold(
                      body: Center(
                        child: Text(
                          state.errMsg,
                          style: TextStyles.cairoBold14.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowNormal,
                      ),
                    ),
                  );
                }

                return CustomScrollViewWithAppBar(
                  onRefresh: () => _refreshProfile(innerContext),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),

                        ProfileAvatarWidget(
                          imageUrl: currentUser!.image,
                          onEditTap: () {
                            Navigator.pushNamed(context, 'EditProfile').then((
                              _,
                            ) {
                              if (innerContext.mounted) {
                                innerContext
                                    .read<UserCubitCubit>()
                                    .getUserInfo();
                              }
                            });
                          },
                        ),

                        Center(
                          child: ProfileUserInfoWidget(
                            name: currentUser!.name,
                            memberSince: currentUser!.memberSince,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        BlocBuilder<ProfileCarCubit, ProfileCarState>(
                          builder: (context, state) {
                            if (state is ProfileCarLoading) {
                              return Skeletonizer(
                                enabled: true,
                                child: CurrentCarCard(
                                  car: CarModel(
                                    id: 0,
                                    brand: 'تويوتا',
                                    model: 'كامري',
                                    year: 2022,
                                    plateNumber: 'أ ب ج ١٢٣٤',
                                    color: 'أبيض',
                                    createdAt: '',
                                    updatedAt: '',
                                  ),
                                ),
                              );
                            } else if (state is ProfileCarSuccess) {
                              final lastCar = state.cars.lastOrNull;
                              return CurrentCarCard(car: lastCar);
                            } else if (state is ProfileCarFailure) {
                              return const CurrentCarCard(car: null);
                            }
                            return const CurrentCarCard(car: null);
                          },
                        ),

                        SizedBox(height: 12.h),

                        CarAnalysis(),

                        SizedBox(height: 24.h),

                        ProfileSection(
                          title: S.of(context).centerOfActivities,
                          children: [
                            ProfileMenuItem(
                              title: S.of(context).myRequests,
                              icon: Icons.assignment_turned_in_outlined,
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed('UserRequests'),
                            ),
                            ProfileSection.divider(),
                            ProfileMenuItem(
                              title: S.of(context).myOffers,
                              icon: Icons.handshake_outlined,
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed('MyOffersPage'),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        // --- الأمان والتحقق ---
                        ProfileSection(
                          title: S.of(context).securityAndVerification,
                          children: [
                            ProfileMenuItem(
                              title: S.of(context).identityVerification,
                              icon: Icons.verified_user_outlined,
                              trailingText: currentUser!.isVerified
                                  ? S.of(context).completed
                                  : S.of(context).incomplete,
                              trailingTextColor: currentUser!.isVerified
                                  ? AppColors.greenNormal
                                  : AppColors.redNormal,
                              onTap: () {
                                if (currentUser!.isVerified) {
                                  return;
                                } else {
                                  Navigator.of(
                                    context,
                                  ).pushNamed('IdentityVarification');
                                }
                              },
                            ),
                            ProfileSection.divider(),
                            ProfileMenuItem(
                              title: S.of(context).privacyAndSecurity,
                              icon: Icons.privacy_tip_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        ProfileSection(
                          title: S.of(context).settings,
                          children: [
                            ProfileMenuItem(
                              title: S.of(context).appLanguage,
                              icon: Icons.language,
                              trailingText: (languageProvider.local == 'en')
                                  ? S.of(context).english
                                  : S.of(context).arabic,
                              trailingTextColor: AppColors.blueNormal,
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed('LanguageScreen'),
                            ),
                            ProfileSection.divider(),
                            ProfileSwitchItem(
                              title: S.of(context).notifications,
                              icon: Icons.notifications_active_outlined,
                              value: isNotificationsEnabled,
                              onChanged: (val) async {
                                setState(() {
                                  isNotificationsEnabled = val;
                                });
                                await AppPref.setBool(
                                  key: 'notifications_enabled',
                                  val: val,
                                );
                                await _applyNotificationSetting(val);
                              },
                            ),
                            ProfileSection.divider(thickness: 0.7),
                            ProfileMenuItem(
                              title: S.of(context).locationSettings,
                              icon: Icons.location_on_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        ProfileSection(
                          title: S.of(context).supportAndAssistance,
                          children: [
                            ProfileMenuItem(
                              title: S.of(context).faq,
                              icon: Icons.help_outline,
                              onTap: () {},
                            ),
                            ProfileSection.divider(),
                            ProfileMenuItem(
                              title: S.of(context).contactUs,
                              icon: Icons.headset_mic_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),

                        CustomElevatedButton(
                          text: S.of(context).logout,
                          radius: CustomRadius.card,
                          fun: () {
                            innerContext.read<LogoutCubit>().logout(context);
                          },
                          backgColor: AppColors.redLightActive,
                          foregColor: AppColors.redDark,
                          prefixIconPath: 'assets/images/log_out.svg',
                          height: 50,
                          fontStyle: TextStyles.cairoBold14,
                        ),
                        SizedBox(height: 90.h),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
