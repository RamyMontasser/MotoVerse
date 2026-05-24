import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_search.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/home/data/models/notification_offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/greating_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/history_listtile.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<RequestsCubit>().fetchRequests(mine: true);
    context.read<MyOffersCubit>().getMyOffers();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await Future.wait([
      context.read<CurrentLocationCubit>().getCurrentLocation(
        forceRefresh: true,
      ),
      context.read<UserCubitCubit>().getUserInfo(),
      context.read<RequestsCubit>().fetchRequests(mine: true),
      context.read<MyOffersCubit>().getMyOffers(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      backgroundColor: AppColors.whiteLight,
      color: AppColors.yellowNormal,
      child: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              CustomSearch(hint: S.of(context).homeSearchHint, search: search),

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
                              .where((request) => request.status == 'pending')
                              .toList()
                              .isNotEmpty ||
                          state.offers
                              .where((request) => request.status == 'accepted')
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
                              .where((request) => request.status == 'pending')
                              .toList()
                              .isNotEmpty ||
                          state.requests
                              .where((request) => request.status == 'accepted')
                              .toList()
                              .isNotEmpty)) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: RequestStatusCard(
                        requests: state.requests,
                        // requestId: state.requests.first.id,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),

              // SizedBox(height: 10.h),
              ListTile(
                title: Text(
                  'الخدمات السريعة',
                  style: TextStyles.cairoBold18.copyWith(
                    color: AppColors.blueDarkActive,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyles.cairoMedium12.copyWith(
                      color: AppColors.whiteDarker,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToolCard(
                    iconPath: Icons.sos,
                    name: 'طلب مساعدة',
                    desc: 'دعم  للحالات الطارئة',
                    fun: () {
                      Navigator.of(context).pushNamed('RequestHelp1');
                    },
                    iconBgColor: AppColors.greenLight,
                    iconColor: AppColors.greenNormal,
                  ),
                  ToolCard(
                    iconPath: Icons.location_on_outlined,
                    name: ' مراكز صيانة قريبة',
                    desc: '12 مركز  قريب منك',
                    fun: () {
                      context.read<NavigationProvider>().changeIndex(3);
                    },
                    iconBgColor: AppColors.orangeLight,
                    iconColor: AppColors.orangeNormal,
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              HistoryListtile(
                title: 'سجل الصيانات',
                iconPath: Icons.history,
                desc: 'آخر صيانة: تغيير زيت – منذ أسبوعين',
                fun: () {
                  Navigator.of(context).pushNamed('history1');
                },
              ),

              SizedBox(height: 20.h),

              Container(
                width: double.infinity,
                height: 150.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha(20),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/Mapbox.png',
                        fit: BoxFit.cover,
                        color: AppColors.blueNormal.withValues(alpha: 0.1),
                        colorBlendMode: BlendMode.luminosity,
                      ),
                    ),

                    Positioned(
                      top: 20.h,
                      right: 70.w,
                      child: SvgPicture.asset('assets/icons/map/blue_pin.svg'),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 90.w,
                      child: SvgPicture.asset('assets/icons/map/blue_pin.svg'),
                    ),
                    Positioned(
                      bottom: 50.h,
                      right: 120.w,
                      child: SvgPicture.asset('assets/icons/map/blue_pin.svg'),
                    ),

                    Positioned(
                      bottom: 10.h,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اعثر على مراكز صيانة قريبة",
                            style: TextStyles.cairoBold12.copyWith(
                              color: AppColors.whiteDarker,
                            ),
                          ),
                          Text(
                            "استكشف أكثر من 24 مركزاً",
                            style: TextStyles.reg10Tajawal.copyWith(
                              color: AppColors.whiteDarkActive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
