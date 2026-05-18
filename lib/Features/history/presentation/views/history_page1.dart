import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/history/presentation/widgets/maintenance_card.dart';
import 'package:motoverse/Features/home/presentation/views/widgets/tool_card.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';
import 'package:motoverse/Features/history/presentation/cubit/history_cubit.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';
import 'package:motoverse/Features/history/data/models/history_summary_model.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class HistoryPage1 extends StatelessWidget {
  const HistoryPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(getIt<HistoryRepo>())..getCarHistory(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              shape: RoundedRectangleBorder(borderRadius: CustomRadius.circle),
              onPressed: () async {
                final result = await Navigator.of(context).pushNamed('history3');
                if (result == true && context.mounted) {
                  context.read<HistoryCubit>().getCarHistory();
                }
              },
              backgroundColor: AppColors.blueNormal,
              child: SvgPicture.asset('assets/icons/home/plus.svg'),
            ),
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    if (state is HistorySuccess) {
                      if (state.history.isEmpty) {
                        return _buildEmptyHistoryContent(context);
                      }
                      return _buildHistoryContent(
                        context,
                        state.history,
                        state.summary,
                        false,
                      );
                    } else if (state is HistoryFailure) {
                      return Center(child: Text(state.errMessage));
                    } else {
                      return _buildHistoryContent(
                        context,
                        _getDummyHistory(),
                        _getDummySummary(),
                        true,
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyHistoryContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80.h),
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColors.yellowLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.history_rounded,
            color: AppColors.yellowNormal,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          'لا يوجد سجل صيانة',
          style: TextStyles.cairoBold24.copyWith(
            color: AppColors.blueNormal,
          ),
        ),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'ابدأ بتوثيق رحلة صيانة سيارتك لتنبيهك بالمواعيد القادمة.',
            textAlign: TextAlign.center,
            style: TextStyles.cairoMedium16.copyWith(
              color: AppColors.whiteDarkActive,
            ),
          ),
        ),
        SizedBox(height: 40.h),
        CustomElevatedButton(
          text: 'اضافة سجل صيانة',
          radius: CustomRadius.card12,
          fun: () async {
            final result = await Navigator.of(context).pushNamed('history3');
            if (result == true && context.mounted) {
              context.read<HistoryCubit>().getCarHistory();
            }
          },
          backgColor: AppColors.blueNormal,
          foregColor: AppColors.whiteLight,
          height: 54.h,
          fontStyle: TextStyles.cairoBold18,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  Widget _buildHistoryContent(
    BuildContext context,
    List<CarHistoryModel> history,
    HistorySummaryModel summary,
    bool isLoading,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToolCard(
                iconPath: Icons.sos,
                name: 'اخر صيانة',
                desc: summary.lastMaintenance?.date ?? 'No history',
                fun: () {
                  Navigator.of(context).pushNamed('history2');
                },
                iconBgColor: AppColors.greenLight,
                iconColor: AppColors.greenNormal,
              ),
              ToolCard(
                iconPath: Icons.payment_outlined,
                name: 'اجمال الدفع',
                desc: '${summary.totalCost} EGP',
                fun: () {},
                iconBgColor: AppColors.orangeLight,
                iconColor: AppColors.orangeNormal,
              ),
            ],
          ),
          Timeline.tileBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15.h),
            theme: TimelineThemeData(nodePosition: 0),
            builder: TimelineTileBuilder.connected(
              indicatorPositionBuilder: (context, index) => 0.0,
              connectorBuilder: (context, index, type) =>
                  const SolidLineConnector(
                thickness: 1,
                color: AppColors.black,
              ),
              lastConnectorBuilder: (context) => const SolidLineConnector(
                thickness: 1,
                color: AppColors.black,
              ),
              indicatorBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(7.w),
                  decoration: const BoxDecoration(
                    color: AppColors.blueLight,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/home/maintenance.svg',
                  ),
                );
              },
              contentsBuilder: (context, index) {
                return MaintenanceCard(historyModel: history[index]);
              },
              itemCount: history.length,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  List<CarHistoryModel> _getDummyHistory() {
    return List.generate(
      2,
      (index) => CarHistoryModel(
        centerName: 'مركز الماسي للصيانة',
        service: 'تغير زيت',
        description: 'وصف الصيانة',
        date: '2023-09-28',
        // time: '04:45 PM',
        cost: '1000', 
        // reading: '100000',
      ),
    );
  }

  HistorySummaryModel _getDummySummary() {
    return HistorySummaryModel(
      lastMaintenance: CarHistoryModel(
        centerName: 'مركز الماسي للصيانة',
        service: 'تغير زيت',
        description: 'وصف الصيانة',
        date: '2023-09-28',
        cost: '1000',
      ),
      totalCost: 2000,
    );
  }
}
