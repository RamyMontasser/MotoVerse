import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
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
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/domain/repo/profile_car_repo.dart';
import 'package:motoverse/Features/profile/presentation/cubit/profile_car/profile_car_cubit.dart';
import 'package:motoverse/Features/profile/presentation/widgets/current_car_card.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_avatar_widget.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_section.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_switch_item.dart';
import 'package:motoverse/Features/profile/presentation/widgets/profile_user_info_widget.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDataModel? currentUser;
  bool isNotificationsEnabled = true;

  Future<void> _refreshProfile(BuildContext blocContext) async {
    await Future.wait([
      blocContext.read<ProfileCarCubit>().fetchCars(),
      blocContext.read<UserCubitCubit>().getUserInfo(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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

                        // --- Current Car Card ---
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
                        SizedBox(height: 24.h),

                        // --- مركز الأنشطة ---
                        ProfileSection(
                          title: 'مركز الأنشطة',
                          children: [
                            ProfileMenuItem(
                              title: 'طلباتي',
                              icon: Icons.assignment_turned_in_outlined,
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed('UserRequests'),
                            ),
                            ProfileSection.divider(),
                            ProfileMenuItem(
                              title: 'عروضي',
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
                          title: 'الأمان والتحقق',
                          children: [
                            ProfileMenuItem(
                              title: 'التحقق من الهوية',
                              icon: Icons.verified_user_outlined,
                              trailingText: currentUser!.isVerified
                                  ? 'مكتمل'
                                  : 'غير مكتمل',
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
                              title: 'الخصوصية والأمان',
                              icon: Icons.privacy_tip_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        // --- الإعدادات ---
                        ProfileSection(
                          title: 'الإعدادات',
                          children: [
                            ProfileMenuItem(
                              title: 'لغة التطبيق',
                              icon: Icons.language,
                              trailingText: 'العربية',
                              trailingTextColor: AppColors.blueNormal,
                              onTap: () =>
                                  Navigator.of(context).pushNamed('settings'),
                            ),
                            ProfileSection.divider(),
                            ProfileSwitchItem(
                              title: 'التنبيهات',
                              icon: Icons.notifications_active_outlined,
                              value: isNotificationsEnabled,
                              onChanged: (val) {
                                setState(() {
                                  isNotificationsEnabled = val;
                                });
                              },
                            ),
                            ProfileSection.divider(thickness: 0.7),
                            ProfileMenuItem(
                              title: 'إعدادات الموقع',
                              icon: Icons.location_on_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        // --- الدعم والمساندة ---
                        ProfileSection(
                          title: 'الدعم والمساندة',
                          children: [
                            ProfileMenuItem(
                              title: 'الأسئلة الشائعة',
                              icon: Icons.help_outline,
                              onTap: () {},
                            ),
                            ProfileSection.divider(),
                            ProfileMenuItem(
                              title: 'تواصل معنا',
                              icon: Icons.headset_mic_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),

                        // --- Logout Button ---
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
