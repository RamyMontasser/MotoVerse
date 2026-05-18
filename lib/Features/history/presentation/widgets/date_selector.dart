import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required DateTime focusDate,
    required this.onChange,
  }) : _focusDate = focusDate;
  final DateTime _focusDate;
  final void Function(DateTime) onChange;

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: _focusDate,
      onDateChange: onChange,
      headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        // dateFormatter: DateFormatter.fullDateDayAsStrMonthAsStr(),
      ),
      dayProps: EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: CustomRadius.r2,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.blueNormal, AppColors.yellowLightActive],
            ),
          ),
        ),
      ),
    );
  }
}
