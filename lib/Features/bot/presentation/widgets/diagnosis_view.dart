import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';


class DiagnosisView extends StatefulWidget {
  const DiagnosisView({super.key});

  @override
  State<DiagnosisView> createState() => _DiagnosisViewState();
}

class _DiagnosisViewState extends State<DiagnosisView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController dtcController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController coolantTempController = TextEditingController();
  final TextEditingController rpmController = TextEditingController();
  final TextEditingController loadController = TextEditingController();
  final TextEditingController speedController = TextEditingController();
  final TextEditingController throttlePosController = TextEditingController();

  bool isArabicSelected = true;

  @override
  void dispose() {
    dtcController.dispose();
    vehicleController.dispose();
    coolantTempController.dispose();
    rpmController.dispose();
    loadController.dispose();
    speedController.dispose();
    throttlePosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.blueGrey),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _DiagnosisHeader(),
            SizedBox(height: 20.h),
            Text(
              'لغة الناتج: ',
              style: TextStyles.cairoBold14.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
            SizedBox(height: 6.h),
            _LanguageToggle(
              isArabicSelected : isArabicSelected,
              onToggle: (value) => setState(() => isArabicSelected = value),
            ),
            SizedBox(height: 24.h),
            _CustomInputGroup(
              label: 'نوع وموديل السيارة',
              controller: vehicleController,
              hint: 'مثال: Mercedes C200 2021 أو Toyota Corolla',
              icon: Icons.directions_car_filled_outlined,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'يرجى إدخال نوع السيارة وموديلها'
                  : null,
            ),
            SizedBox(height: 24.h),
            _CustomInputGroup(
              label: 'كود العطل (OBD Code)',
              controller: dtcController,
              hint: 'P0420',
              icon: Icons.search,
              style: TextStyles.cairoBold16.copyWith(color: AppColors.blueDark),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'يرجى إدخال كود العطل أولاً'
                  : null,
            ),
            SizedBox(height: 20.h),
            const Divider(color: AppColors.blueGrey),
            SizedBox(height: 12.h),
            Text(
              'بيانات الحساسات الحية: ',
              style: TextStyles.cairoBold14.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
            SizedBox(height: 16.h),
            _SensorsSection(
              coolantController: coolantTempController,
              rpmController: rpmController,
              loadController: loadController,
              speedController: speedController,
              throttleController: throttlePosController,
            ),
            SizedBox(height: 35.h),
            _buildSubmitButton(context),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }

Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'تحليل الكود والبيانات',
      radius: BorderRadius.circular(16.r),
      height: 48,
      fontStyle: TextStyles.cairoBold16,
      fun: () {
        if (_formKey.currentState!.validate()) {
          final Map<String, dynamic> finalEndpointBody = {
            "dtc_codes": [dtcController.text.trim().toUpperCase()],
            "sensor_data": {
              "ENGINE_COOLANT_TEMP":
                  num.tryParse(coolantTempController.text) ?? 0,
              "ENGINE_RPM": num.tryParse(rpmController.text) ?? 0,
              "ENGINE_LOAD": num.tryParse(loadController.text) ?? 0,
              "SPEED": num.tryParse(speedController.text) ?? 0,
              "THROTTLE_POS": num.tryParse(throttlePosController.text) ?? 0,
            },
            "vehicle": vehicleController.text.trim(),
            "language": isArabicSelected ? "Arabic" : "English",
          };

          debugPrint("Final JSON Body for Endpoint: $finalEndpointBody");

          Navigator.of(
            context,
          ).pushNamed('AiAssistant', arguments: finalEndpointBody);
        } else {
          customSnackBar(
            context: context,
            msg: 'يرجى تصحيح الأخطاء في الحقول الحمراء أولاً.',
            isDone: false,
          );
        }
      },
    );
  }
}


class _DiagnosisHeader extends StatelessWidget {
  const _DiagnosisHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.hub_outlined,
              color: AppColors.yellowNormal,
              size: 26.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'تحليل أكواد الأعطال (OBD)',
              style: TextStyles.cairoBold16.copyWith(
                color: AppColors.blueNormal,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'فهم أكواد السيارة واكتشاف المشكلات التقنية بدقة ووضوح.',
          style: TextStyles.cairoRegular13.copyWith(
            color: AppColors.whiteDarkHover,
          ),
        ),
      ],
    );
  }
}


class _LanguageToggle extends StatelessWidget {
  final bool isArabicSelected;
  final ValueChanged<bool> onToggle;

  const _LanguageToggle({
    required this.isArabicSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: isArabicSelected
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.49,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blueNormal,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          Row(
            children: [
              _buildToggleButton(
                label: 'العربية',
                isSelected: isArabicSelected,
                onTap: () => onToggle(true),
              ),
              _buildToggleButton(
                label: 'الانجليزية',
                isSelected: !isArabicSelected,
                onTap: () => onToggle(false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: TextStyles.cairoBold13.copyWith(
              color: isSelected ? AppColors.whiteLight : AppColors.whiteDarker,
            ),
          ),
        ),
      ),
    );
  }
}


class _CustomInputGroup extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? style;
  final FormFieldValidator<String>? validator;

  const _CustomInputGroup({
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.style,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.cairoRegular13.copyWith(
            color: AppColors.blueNormal,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          cursorColor: AppColors.yellowNormal,
          style:
              style ??
              TextStyles.cairoBold14.copyWith(color: AppColors.blueDark),
          decoration: _buildInputDecoration(hint: hint, icon: icon),
          validator: validator,
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyles.cairoRegular14.copyWith(color: AppColors.whiteDark),
      prefixIcon: icon != null ? Icon(icon, color: AppColors.whiteDark) : null,
      fillColor: AppColors.whiteNormal,
      filled: true,
  
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      errorStyle: TextStyles.cairoRegular11.copyWith(
        color: AppColors.redNormal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.blueGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.blueGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.blueNormal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.redNormal),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.redNormal, width: 1.5),
      ),
    );
  }
}


class _SensorsSection extends StatelessWidget {
  final TextEditingController coolantController;
  final TextEditingController rpmController;
  final TextEditingController loadController;
  final TextEditingController speedController;
  final TextEditingController throttleController;

  const _SensorsSection({
    required this.coolantController,
    required this.rpmController,
    required this.loadController,
    required this.speedController,
    required this.throttleController,
  });

  String? _validateNumeric(String? value) {
    if (value != null && value.isNotEmpty) {
      final num? checkNum = num.tryParse(value);
      if (checkNum == null) return 'أرقام فقط';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CustomInputGroup(
                label: 'حرارة المحرك',
                controller: coolantController,
                hint: '95 °C',
                keyboardType: TextInputType.number,
                validator: _validateNumeric,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _CustomInputGroup(
                label: 'دورات المحرك',
                controller: rpmController,
                hint: '2500 RPM',
                keyboardType: TextInputType.number,
                validator: _validateNumeric,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CustomInputGroup(
                label: 'الحمل على المحرك',
                controller: loadController,
                hint: '65 %',
                keyboardType: TextInputType.number,
                validator: _validateNumeric,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _CustomInputGroup(
                label: 'سرعة السيارة',
                controller: speedController,
                hint: '80 km/h',
                keyboardType: TextInputType.number,
                validator: _validateNumeric,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _CustomInputGroup(
          label: 'موضع دواسة الوقود (Throttle)',
          controller: throttleController,
          hint: '20 %',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          validator: _validateNumeric,
        ),
      ],
    );
  }
}
