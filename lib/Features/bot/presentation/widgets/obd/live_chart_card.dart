import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';

class LiveChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final List<FlSpot> spots;
  final double maxY;

  const LiveChartCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.spots,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.orangeLight,
                    child: Icon(
                      icon,
                      size: 22.r,
                      color: AppColors.yellowNormal,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: TextStyles.cairoBold14.copyWith(
                      color: AppColors.blueDarkHover,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: Alignment.baseline,
                // textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    unit,
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.whiteDarkHover,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    value,
                    style: TextStyles.cairoBold18.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.blueLight.withValues(alpha: 0.5),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.w,
                      getTitlesWidget: (value, meta) {
                        String text = value.toInt().toString();
                        if (maxY == 40 && value > 0) text = '${value.toInt()}k';
                        return Text(
                          text,
                          style: TextStyles.cairoRegular13.copyWith(
                            color: AppColors.whiteDark,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 9,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.yellowNormal,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.yellowNormal.withValues(alpha: 0.2),
                          AppColors.yellowNormal.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
