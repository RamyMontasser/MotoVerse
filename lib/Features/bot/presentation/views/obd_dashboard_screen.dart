import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/bot/data/models/obd_metrics.dart';
import 'package:motoverse/Features/bot/domain/repo/obd_repo.dart';
import 'package:motoverse/Features/bot/presentation/cubit/obd_cubit.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/ai_analysis_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/engine_load_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/fault_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/live_chart_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/stat_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/stat_card2.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/data_file_picker_card.dart';
import 'package:motoverse/generated/l10n.dart';


class ObdDashboardScreen extends StatelessWidget {
  const ObdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => ObdCubit(getIt<ObdRepo>()),
    child:Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: BlocBuilder<ObdCubit, ObdState>(
              builder: (context, state) {
                if (state is ObdLoading) {
                  return _buildLoadingView(context);
                }

                if (state is ObdDataUpdated) {
                  return _buildDashboardView(context, state.metrics);
                }

                if (state is ObdError) {
                  return _buildErrorView(state.errorMessage);
                }
                return _buildPickerView(context);
              },
            ),
          ),
        ),
      ),
    )
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return SizedBox(
      key: const ValueKey('obd_loading_view'),
      height: 0.7.sh,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.blueNormal,
              strokeWidth: 3.w,
            ),
            SizedBox(height: 16.h),
            Text(
              S.of(context).loading,
              style: TextStyles.cairoMedium14.copyWith(
                color: AppColors.whiteDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardView(BuildContext context, ObdMetrics metrics) {
    return Column(
      key: const ValueKey('obd_dashboard_view'),
      children: [
        if (metrics.faultCode != null) ...[
          FaultCard(faultCode: metrics.faultCode!),
          SizedBox(height: 18.h),
        ],

        AiAnalysisCard(
          carModel: metrics.carModel,
          anomalyPercentage: 82,
        ),
        SizedBox(height: 18.h),

        Row(
          children: [
            Expanded(
              child: StatCard(
                title: S.of(context).fuelLevel,
                value: metrics.fuelLevel,
                icon: Icons.local_gas_station,
                progress: metrics.fuelProgress,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: StatCard(
                title: S.of(context).engineTemperature,
                value: metrics.engineTemp,
                icon: Icons.thermostat,
                progress: metrics.tempProgress,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),

        EngineLoadCard(
          title: S.of(context).engineLoad,
          value: metrics.engineLoad,
          progress: metrics.loadProgress,
          icon: Icons.speed,
          iconColor: AppColors.blueNormal,
          bgColor: AppColors.blueLight,
        ),
        SizedBox(height: 18.h),

        LiveChartCard(
          title: S.of(context).engineRpm,
          value: metrics.rpmValue,
          unit: 'RPM',
          icon: Icons.bar_chart,
          maxY: 3000,
          spots: metrics.rpmSpots.isEmpty
              ? [const FlSpot(0, 0)]
              : metrics.rpmSpots,
        ),
        SizedBox(height: 18.h),

        LiveChartCard(
          title: S.of(context).vehicleSpeed,
          value: metrics.speedValue,
          unit: 'km/h',
          icon: Icons.av_timer,
          maxY: 150,
          spots: metrics.speedSpots.isEmpty
              ? [const FlSpot(0, 0)]
              : metrics.speedSpots,
        ),
        SizedBox(height: 18.h),

        Row(
          children: [
            Expanded(
              child: StatCard2(
                title: S.of(context).intakeAirTemperature,
                value: metrics.intakeAirTemp,
                icon: Icons.device_thermostat,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: StatCard2(
                title: S.of(context).barometricPressure,
                value: metrics.barometricPressure,
                icon: Icons.speed,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),

        EngineLoadCard(
          title: S.of(context).engineRuntime,
          value: metrics.runtimeValue,
          icon: Icons.timer_outlined,
          iconColor: AppColors.yellowNormal,
          bgColor: AppColors.yellowLight,
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildPickerView(BuildContext context) {
    return Container(
      key: const ValueKey('obd_picker_view'),
      height: 0.7.sh,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DataFilePickerCard(
            hasFile: false,
            onPickFile: () async {
              try {
                FilePickerResult? result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv',],
                );

                if (result != null && result.files.isNotEmpty) {
                  if (context.mounted) {
                    context.read<ObdCubit>().startSimulation(
                      result.files.first,
                    );
                  }
                }
              } catch (e) {
                debugPrint("خطأ أثناء اختيار الملف: $e");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return SizedBox(
      key: const ValueKey('obd_error_view'),
      height: 0.7.sh,
      child: Center(
        child: Text(
          message,
          style: TextStyles.cairoMedium14.copyWith(color: AppColors.redNormal),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
