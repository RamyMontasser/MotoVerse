import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
// import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart'; 
import 'package:motoverse/Features/bot/presentation/widgets/obd/ai_analysis_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/engine_load_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/faukt_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/live_chart_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/stat_card.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/stat_card2.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/data_file_picker_card.dart'; 
import 'package:motoverse/generated/l10n.dart';

class ObdDashboardScreen extends StatefulWidget {
  const ObdDashboardScreen({super.key});

  @override
  State<ObdDashboardScreen> createState() => _ObdDashboardScreenState();
}

class _ObdDashboardScreenState extends State<ObdDashboardScreen> {
  bool _hasFile = false;
  bool _isLoading = false;
  bool _showDashboard = false;
  PlatformFile? _pickedFile;

 Future<void> _handlePickFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'csv', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedFile = result.files.first;
          _hasFile = true;
        });
        _handleAnalyzeData();
        debugPrint("تم اختيار ملف بنجاح: ${_pickedFile!.name}");
      } else {
        debugPrint("المستخدم ألغى عملية الاختيار");
      }
    } catch (e) {
      debugPrint("خطأ أثناء اختيار الملف: $e");
    }
  }

  // void _handleReuploadFile() {
  //   setState(() {
  //     _pickedFile = null;
  //     _hasFile = false;
  //   });
  // }

  Future<void> _handleAnalyzeData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _showDashboard = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: _buildCurrentStateView(),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStateView() {
    if (_isLoading) {
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

    if (_showDashboard) {
      return Column(
        key: const ValueKey('obd_dashboard_view'),
        children: [
          const FaultCard(faultCode: 'P0171'),
          SizedBox(height: 18.h),

          const AiAnalysisCard(
            carModel: 'Toyota Corolla 2020',
            anomalyPercentage: 82,
          ),
          SizedBox(height: 18.h),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: S.of(context).fuelLevel,
                  value: '62%',
                  icon: Icons.local_gas_station,
                  progress: 0.62,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: StatCard(
                  title: S.of(context).engineTemperature,
                  value: '88°C',
                  icon: Icons.thermostat,
                  progress: 0.65,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          EngineLoadCard(
            title: S.of(context).engineLoad,
            value: '62%',
            progress: 0.62,
            icon: Icons.speed,
            iconColor: AppColors.blueNormal,
            bgColor: AppColors.blueLight,
          ),
          SizedBox(height: 18.h),

          const LiveChartCard(
            title: 'Engine RPM',
            value: '2,450',
            unit: 'RPM',
            icon: Icons.bar_chart,
            maxY: 40,
            spots: [
              FlSpot(0, 18),
              FlSpot(1, 8),
              FlSpot(2, 13),
              FlSpot(3, 14),
              FlSpot(4, 27),
              FlSpot(5, 22),
              FlSpot(6, 29),
              FlSpot(7, 16),
              FlSpot(8, 13),
              FlSpot(9, 1),
            ],
          ),
          SizedBox(height: 18.h),

          const LiveChartCard(
            title: 'Vehicle Speed',
            value: '65',
            unit: 'km/h',
            icon: Icons.av_timer,
            maxY: 120,
            spots: [
              FlSpot(0, 50),
              FlSpot(1, 20),
              FlSpot(2, 38),
              FlSpot(3, 42),
              FlSpot(4, 80),
              FlSpot(5, 65),
              FlSpot(6, 88),
              FlSpot(7, 48),
              FlSpot(8, 38),
              FlSpot(9, 0),
            ],
          ),
          SizedBox(height: 18.h),

          Row(
            children: [
              Expanded(
                child: StatCard2(
                  title: S.of(context).intakeAirTemperature,
                  value: '88°C',
                  icon: Icons.device_thermostat,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: StatCard2(
                  title: S.of(context).barometricPressure,
                  value: '101.2 kPa',
                  icon: Icons.speed,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          EngineLoadCard(
            title: S.of(context).engineRuntime,
            value: '01:24:15',
            icon: Icons.timer_outlined,
            iconColor: AppColors.yellowNormal,
            bgColor: AppColors.yellowLight,
          ),
          SizedBox(height: 40.h),
        ],
      );
    }

    return Container(
      key: const ValueKey('obd_picker_view'),
      height: 0.7.sh, 
      padding: EdgeInsets.symmetric(horizontal: 8.w,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DataFilePickerCard(
            hasFile: _hasFile,
            onPickFile: _handlePickFile,
            // onReuploadFile: _handleReuploadFile,
          ),
          // if (_hasFile) ...[
          //   SizedBox(height: 32.h),
          //   CustomElevatedButton(
          //     text: S.of(context).analyzeData,
          //     fun: _handleAnalyzeData,
          //     width: double.infinity,
          //     backgColor: AppColors.yellowNormal,
          //     foregColor: AppColors.whiteLight, 
          //     radius: CustomRadius.card12, 
          //     height: 48, 
          //     fontStyle: TextStyles.cairoBold14,
          //   ),
          // ],
        ],
      ),
    );
  }
}
