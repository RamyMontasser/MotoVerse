import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_search.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';
import 'package:motoverse/Features/history/presentation/cubit/history_cubit.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/greating_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/history_listtile.dart';
import 'package:motoverse/Features/home/presentation/widgets/home_map_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/my_offer_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/request_status_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/tool_card.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  List<RequestModel> requests = [];

  String formatDate(String date) {
    final dt = DateTime.parse(date);
    return DateFormat('yyyy/MM/dd').format(dt);
  }

  @override
  void initState() {
    super.initState();
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
    context.read<MyOffersCubit>().getMyOffers();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  Future<void> _refreshData(BuildContext context) async {
    await context.read<CurrentLocationCubit>().getCurrentLocation(
      forceRefresh: true,
    );

    final currentLocationState = context.read<CurrentLocationCubit>().state;
    double? latitude;
    double? longitude;
    if (currentLocationState is CurrentLocationSuccess) {
      latitude = currentLocationState.currentLocation.latitude;
      longitude = currentLocationState.currentLocation.longitude;
    }

    await Future.wait([
      context.read<UserCubitCubit>().getUserInfo(),
      context.read<RequestsCubit>().fetchRequests(
        mine: true,
        latitude: latitude,
        longitude: longitude,
      ),
      context.read<MyOffersCubit>().getMyOffers(),
      context.read<HistoryCubit>().getCarHistory(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(getIt<HistoryRepo>())..getCarHistory(),
      child: Builder(
        builder: (innerContext) {
          return CustomScrollViewWithAppBar(
            onRefresh: () => _refreshData(innerContext),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearch(
                    hint: S.of(context).homeSearchHint,
                    search: search,
                  ),
                  SizedBox(height: 15.h),
                  GreatingCard(),
                  BlocBuilder<MyOffersCubit, MyOffersState>(
                    buildWhen: (previous, current) =>
                        current is MyOffersLoading ||
                        current is MyOffersSuccess ||
                        current is MyOffersFailure,
                    builder: (context, state) {
                      if (state is MyOffersLoading) {
                        return Column(
                          children: [
                            SizedBox(height: 15.h),
                            Skeletonizer(child: const MyOfferCard(offers: [])),
                          ],
                        );
                      }
                      if (state is MyOffersSuccess &&
                          (state.offers
                                  .where(
                                    (request) => request.status == 'pending',
                                  )
                                  .toList()
                                  .isNotEmpty ||
                              state.offers
                                  .where(
                                    (request) => request.status == 'accepted',
                                  )
                                  .toList()
                                  .isNotEmpty)) {
                        List<OfferModel> offers = state.offers
                            .where(
                              (request) =>
                                  request.status == 'pending' ||
                                  request.status == 'accepted',
                            )
                            .toList();
                        return Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: MyOfferCard(offers: offers),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  BlocBuilder<RequestsCubit, RequestsState>(
                    builder: (context, state) {
                      if (state is RequestsLoading) {
                        return Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: const Skeletonizer(
                            child: RequestStatusCard(requests: []),
                          ),
                        );
                      }

                      if (state is RequestsSuccess &&
                          (state.requests
                                  .where(
                                    (request) => request.status == 'pending',
                                  )
                                  .toList()
                                  .isNotEmpty ||
                              state.requests
                                  .where(
                                    (request) => request.status == 'accepted',
                                  )
                                  .toList()
                                  .isNotEmpty)) {
                        return Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: RequestStatusCard(requests: state.requests),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    S.of(context).quickServices,
                    style: TextStyles.cairoBold18.copyWith(
                      color: AppColors.blueDarkActive,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ToolCard(
                          iconPath: Icons.sos,
                          name: S.of(context).requestHelp,
                          desc: S.of(context).emergencySupport,
                          fun: () {
                            Navigator.of(context).pushNamed('RequestHelp1');
                          },
                          iconBgColor: AppColors.greenLight,
                          iconColor: AppColors.greenNormal,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child:
                            BlocBuilder<
                              CurrentLocationCubit,
                              CurrentLocationState
                            >(
                              builder: (context, state) {
                                int centersCount = 0;
                                if (state is CurrentLocationSuccess) {
                                  centersCount = state.nearestCentersCount;
                                }
                                if (state is CurrentLocationLoading) {
                                  return Skeletonizer(
                                    child: ToolCard(
                                      iconPath: Icons.location_on_outlined,
                                      name: S.of(context).nearbyMaintenance,
                                      desc: S
                                          .of(context)
                                          .nearestCentersCount(centersCount),
                                      fun: () {
                                        context
                                            .read<NavigationProvider>()
                                            .changeIndex(3);
                                      },
                                      iconBgColor: AppColors.orangeLight,
                                      iconColor: AppColors.orangeNormal,
                                    ),
                                  );
                                }

                                return ToolCard(
                                  iconPath: Icons.location_on_outlined,
                                  name: S.of(context).nearbyMaintenance,
                                  desc: centersCount != 0
                                      ? S
                                            .of(context)
                                            .nearestCentersCount(centersCount)
                                      : S.of(context).noNearbyCenters,
                                  fun: () {
                                    context
                                        .read<NavigationProvider>()
                                        .changeIndex(3);
                                  },
                                  iconBgColor: AppColors.orangeLight,
                                  iconColor: AppColors.orangeNormal,
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      if (state is HistoryLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: HistoryListtile(
                            title: S.of(context).maintenanceHistory,
                            iconPath: Icons.history,
                            desc: S.of(context).loadingTechnicalData,
                            fun: () {},
                          ),
                        );
                      }

                      if (state is HistorySuccess && state.history.isNotEmpty) {
                        final lastHistory = state.history.first;

                        return HistoryListtile(
                          title: S.of(context).maintenanceHistory,
                          iconPath: Icons.history,
                          desc: S
                              .of(context)
                              .lastMaintenanceDetails(
                                lastHistory.service,
                                formatDate(lastHistory.date),
                              ),
                          fun: () {
                            Navigator.of(context).pushNamed('history1');
                          },
                        );
                      }

                      return HistoryListtile(
                        title: S.of(context).maintenanceHistory,
                        iconPath: Icons.history,
                        desc: S.of(context).noMaintenanceHistory,
                        fun: () {
                          Navigator.of(context).pushNamed('history1');
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () =>
                        context.read<NavigationProvider>().changeIndex(3),
                    child: const HomeMapCard(),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
