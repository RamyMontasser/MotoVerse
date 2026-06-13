import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/community/presentation/widgets/user_request_page_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/user_requests_category_tabs.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:motoverse/generated/l10n.dart';

class UserRequestsScreen extends StatefulWidget {
  const UserRequestsScreen({super.key, this.initialCategory = 0});

  final int initialCategory;

  @override
  State<UserRequestsScreen> createState() => _UserRequestsScreenState();
}

class _UserRequestsScreenState extends State<UserRequestsScreen> {
  late int currentCategory;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.initialCategory;
    final currentLocationState = context.read<CurrentLocationCubit>().state;
    double? latitude;
    double? longitude;
    if (currentLocationState is CurrentLocationSuccess) {
      latitude = currentLocationState.currentLocation.latitude;
      longitude = currentLocationState.currentLocation.longitude;
    }
    context.read<RequestsCubit>().fetchRequests(
      mine: true,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).myRequests,
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),
              UserRequestsCategoryTabs(
                selectedIndex: currentCategory,
                onTap: (index) {
                  setState(() {
                    currentCategory = index;
                  });
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<RequestsCubit, RequestsState>(
                builder: (context, state) {
                  if (state is RequestsLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(S.of(context).loading),
                            subtitle: Text(S.of(context).loading),
                          ),
                        ),
                      ),
                    );
                  } else if (state is RequestsFail) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is RequestsSuccess) {
                    final requests = currentCategory == 0
                        ? state.requests
                        : state.requests
                              .where(
                                (request) =>
                                    request.status == 'pending' ||
                                    request.status == 'accepted',
                              )
                              .toList();
                    if (requests.isEmpty) {
                      final bool isActiveTab = currentCategory == 1;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 100.h),
                            Icon(
                              isActiveTab
                                  ? Icons.hourglass_empty
                                  : Icons.request_page,
                              size: 80.sp,
                              color: isActiveTab
                                  ? AppColors.yellowNormal
                                  : AppColors.blueGrey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              isActiveTab
                                  ? S.of(context).noActiveRequests
                                  : S.of(context).noPreviousRequests,
                              textAlign: TextAlign.center,
                              style: TextStyles.cairoBold16.copyWith(
                                color: AppColors.blueDarkActive,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              S.of(context).emptyRequestsSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyles.cairoRegular14.copyWith(
                                color: AppColors.whiteDarkActive,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final RequestModel request = requests[index];
                        return UserRequestPageCard(request: request);
                      },
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
