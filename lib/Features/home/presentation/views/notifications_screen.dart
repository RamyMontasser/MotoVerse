import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/home/presentation/cubit/device_notification_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/notification_card.dart';
import 'package:motoverse/generated/l10n.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeviceNotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      body: CustomScrollViewWithAppBar(
        onRefresh: () async {
          await context.read<DeviceNotificationCubit>().fetchNotifications(
            isRefresh: true,
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  S.of(context).notifications1,
                  style: TextStyles.cairoBold18.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              BlocBuilder<DeviceNotificationCubit, DeviceNotificationState>(
                builder: (context, state) {
                  if (state is DeviceNotificationLoading) {
                    return SizedBox(
                      height: 400.h,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blueNormal,
                        ),
                      ),
                    );
                  }

                  if (state is DeviceNotificationError) {
                    return SizedBox(
                      height: 400.h,
                      child: Center(
                        child: Text(
                          state.failure.errorMsg,
                          style: TextStyles.cairoMedium16.copyWith(
                            color: AppColors.redNormal,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is DeviceNotificationSuccess) {
                    final apiNotifications = state.notifications;

                    if (apiNotifications.isEmpty) {
                      return SizedBox(
                        height: 400.h,
                        child: Center(
                          child: Text(
                            S.of(context).noNotifications,
                            style: TextStyles.cairoMedium16.copyWith(
                              color: AppColors.whiteDarkActive,
                            ),
                          ),
                        ),
                      );
                    }
                    debugPrint(
                      'latest notification: ${apiNotifications.first.createdAt}',
                    );

                    final todayNotifications = apiNotifications.where((n) {
                      return n.createdAt.year == now.year &&
                          n.createdAt.month == now.month &&
                          n.createdAt.day == now.day;
                    }).toList();

                    final pastNotifications = apiNotifications.where((n) {
                      return !(n.createdAt.year == now.year &&
                          n.createdAt.month == now.month &&
                          n.createdAt.day == now.day);
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (todayNotifications.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              S.of(context).today,
                              style: TextStyles.cairoBold16.copyWith(
                                color: AppColors.blueNormal,
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: todayNotifications.length,
                            separatorBuilder: (context, index) => Divider(
                              color: AppColors.blueGrey,
                              thickness: 1.h,
                            ),
                            itemBuilder: (context, index) => NotificationCard(
                              notification: todayNotifications[index],
                            ),
                          ),
                        ],
                        if (pastNotifications.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                            child: Text(
                              S.of(context).past,
                              style: TextStyles.cairoBold16.copyWith(
                                color: AppColors.blueNormal,
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: pastNotifications.length,
                            separatorBuilder: (context, index) => Divider(
                              color: AppColors.blueGrey,
                              thickness: 1.h,
                            ),
                            itemBuilder: (context, index) => NotificationCard(
                              notification: pastNotifications[index],
                            ),
                          ),
                        ],
                        SizedBox(height: 100.h),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
