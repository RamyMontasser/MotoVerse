// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
// import 'package:motoverse/Core/theme/button_radius.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/auth/domain/repo/auth_repo.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/profile_option.dart';
import 'package:motoverse/Features/home/presentation/widgets/profile_tile.dart';
import 'package:motoverse/generated/l10n.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final String name = 'رامي منتصر';
  UserDataModel? currentUser;

  // @override
  // void initState() {
  //   super.initState();
  //   final userBox = Hive.box<UserDataModel>('user_box');
  //   currentUser = userBox.get('user');
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubitCubit, UserCubitState>(
      builder: (context, state) {
        final userBox = Hive.box<UserDataModel>('user_box');
        currentUser = userBox.get('user');

        if (currentUser == null) {
          if (state is GetUserInfoFailure) {
            return CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
                child: Center(
                  child: Text(
                    state.errMsg,
                    style: TextStyles.cairoBold14.copyWith(color: Colors.red),
                  ),
                ),
              ),
            );
          }
          return const CustomScrollViewWithAppBar(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 250),
              child: Center(
                child: CircularProgressIndicator(
                    color: AppColors.yellowNormal,
                ),
              ),
            ),
          );
        }

        return CustomScrollViewWithAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileTile(name: currentUser!.name, email: currentUser!.email,),
                // currentUser.
                CustomElevatedButton(
                  text: 'التحقق من الهوية',
                  radius: CustomRadius.card,
                  fun: () {
                    Navigator.of(context).pushNamed('IdentityVarification');
                  },
                  backgColor: AppColors.whiteLight,
                  foregColor: AppColors.blueNormal,
                  height: 50, fontStyle: TextStyles.cairoBold12,),
                
                // CustomElevatedButton(
                //   text: 'firebase',
                //   radius: CustomRadius.card,
                //   fun: () async {
                //     final user =await FirebaseAuth.instance.signInAnonymously();

                //     debugPrint(user.user?.uid);

                //   },
                //   backgColor: AppColors.whiteLight,
                //   foregColor: AppColors.blueNormal,
                //   height: 50, fontStyle: TextStyles.cairoBold12,),

                ProfileOption(
                  title: S.of(context).profile,
                  desc: S.of(context).profileDesc,
                  iconPath: 'assets/images/profile_person.svg',
                  fun: () {},
                ),
                ProfileOption(
                  title: S.of(context).dashboard,
                  desc: S.of(context).myCars,
                  iconPath: 'assets/images/profile_car.svg',
                  fun: () {},
                ),
                ProfileOption(
                  title: S.of(context).aboutUs,
                  desc: S.of(context).aboutUsDesc,
                  iconPath: 'assets/images/profile_documment.svg',
                  fun: () {},
                ),
                ProfileOption(
                  title: 'طلباتي',
                  desc: 'عرض جميع طلبات المساعدة الخاصة بك',
                  iconPath: 'assets/images/profile_documment.svg',
                  fun: () {
                    Navigator.of(context).pushNamed('UserRequests');
                  },
                ),
                ProfileOption(
                  title: 'عروضي',
                  desc: 'عرض جميع العروض التي قدمتها',
                  iconPath: 'assets/images/profile_car.svg',
                  fun: () {
                    Navigator.of(context).pushNamed('MyOffersPage');
                  },
                ),
                ProfileOption(
                  title: S.of(context).settings,
                  desc: S.of(context).settingsDesc,
                  iconPath: 'assets/images/profile_settings.svg',
                  fun: () {
                    Navigator.of(context).pushNamed('settings');
                  },
                ),

                SizedBox(height: 20.h),

                CustomElevatedButton(
                  text: S.of(context).logout,
                  radius: CustomRadius.card,
                  fun: () async {
                    await getIt<AuthRepo>().logOut();
                    if (context.mounted) {
                      context.read<NavigationProvider>().changeIndex(0);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        'log in',
                        (route) => false,
                      );
                    }
                  },
                  withBorder: true,
                  backgColor: AppColors.whiteLight,
                  foregColor: AppColors.blueNormal,
                  prefixIconPath: 'assets/images/log_out.svg', height: 50, fontStyle: TextStyles.cairoBold12,
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                            'Are you sure you want to delete your account? This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              final result = await getIt<AuthRepo>().deleteAccount();
                              result.fold(
                                (failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(failure.errorMsg)),
                                  );
                                },
                                (success) {
                                  context.read<NavigationProvider>().changeIndex(0);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    'log in',
                                    (route) => false,
                                  );
                                },
                              );
                            },
                            child: const Text('Delete',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
