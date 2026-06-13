import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/errors/app_validator.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';
import 'package:motoverse/Features/history/presentation/cubit/history_cubit.dart';
import 'package:motoverse/Features/history/presentation/widgets/date_selector.dart';
import 'package:motoverse/generated/l10n.dart';

class HistoryPage3 extends StatefulWidget {
  const HistoryPage3({super.key});

  @override
  State<HistoryPage3> createState() => _HistoryPage3State();
}

class _HistoryPage3State extends State<HistoryPage3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController date = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController centerName = TextEditingController();

  DateTime _focusDate = DateTime.now();

  @override
  void dispose() {
    date.dispose();
    type.dispose();
    desc.dispose();
    price.dispose();
    centerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HistoryCubit(getIt<HistoryRepo>()),
        child: BlocListener<HistoryCubit, HistoryState>(
          listener: (context, state) {
            if (state is AddHistorySuccess) {
              Navigator.of(context).pop(true);
            } else if (state is AddHistoryFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errMessage)));
            }
          },
          child: CustomScrollViewWithAppBar(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteLight,
                  borderRadius: CustomRadius.auth,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).newMaintenanceRecord,
                        style: TextStyles.cairoSemiBold20.copyWith(
                          color: AppColors.blueDark,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        S.of(context).dateLabel,
                        style: TextStyles.cairoRegular14.copyWith(
                          color: AppColors.blueDarkHover,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      DateSelector(
                        focusDate: _focusDate,
                        onChange: (selectedDate) {
                          setState(() {
                            _focusDate = selectedDate;
                            date.text = DateFormat(
                              'yyyy-MM-dd',
                              'en',
                            ).format(selectedDate);
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      _buildField(
                        label: S.of(context).maintenanceCenter,
                        controller: centerName,
                      ),
                      _buildField(
                        label: S.of(context).maintenanceType,
                        controller: type,
                      ),
                      _buildField(
                        label: S.of(context).descriptionLabel,
                        controller: desc,
                        maxLines: 3,
                      ),
                      _buildField(
                        label: S.of(context).costEgp,
                        controller: price,
                        isNumber: true,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<HistoryCubit, HistoryState>(
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  text: state is AddHistoryLoading
                                      ? S.of(context).saving
                                      : S.of(context).save,
                                  radius: CustomRadius.r1,
                                  fun: state is AddHistoryLoading
                                      ? () {}
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<HistoryCubit>()
                                                .addHistory(
                                                  CarHistoryModel(
                                                    date: date.text,
                                                    centerName: centerName.text,
                                                    service: type.text,
                                                    description: desc.text,
                                                    cost: price.text,
                                                  ),
                                                );
                                          }
                                        },
                                  height: 40,
                                  withBorder: false,
                                  fontStyle: TextStyles.cairoRegular16,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomElevatedButton(
                              text: S.of(context).cancel,
                              radius: CustomRadius.r1,
                              fun: () {
                                Navigator.of(context).pop();
                              },
                              height: 40,
                              withBorder: false,
                              fontStyle: TextStyles.cairoRegular16,
                              backgColor: AppColors.blueLight,
                              foregColor: AppColors.blueNormal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    bool isNumber = false,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.cairoRegular14.copyWith(
              color: AppColors.blueDarkHover,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            readOnly: readOnly,
            cursorColor: AppColors.yellowNormal,
            onTap: onTap,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            validator: AppValidator.validateEmpty,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: AppColors.whiteLight,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.blueLightHover),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.blueNormalHover,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
