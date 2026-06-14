import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/errors/app_validator.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_app_dialog.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_textfeild_with_border.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/presentation/cubit/profile_car_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class AddOrUpdateCarScreen extends StatefulWidget {
  const AddOrUpdateCarScreen({super.key});

  @override
  State<AddOrUpdateCarScreen> createState() => _AddOrUpdateCarScreenState();
}

class _AddOrUpdateCarScreenState extends State<AddOrUpdateCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();

  String _selectedColor = 'white';
  bool _isInitialized = false;
  bool _isEditMode = false;
  int? _carId;

  final Map<String, Color> _colorMap = {
    'white': AppColors.whiteLight,
    'black': AppColors.black,
    'grey': Colors.grey,
    'red': Colors.red,
    'blue': Colors.blue,
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is CarModel) {
        _isEditMode = true;
        _carId = args.id;
        _brandController.text = args.brand;
        _modelController.text = args.model;
        _yearController.text = args.year.toString();
        _plateController.text = args.plateNumber;
        _selectedColor = args.color.toLowerCase();
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final car = CarModel(
        id: _isEditMode ? _carId! : 0,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        year: int.tryParse(_yearController.text.trim()) ?? 0,
        plateNumber: _plateController.text.trim(),
        color: _selectedColor,
        createdAt: '',
        updatedAt: '',
      );

      if (_isEditMode) {
        context.read<ProfileCarCubit>().updateCar(_carId!, car);
      } else {
        context.read<ProfileCarCubit>().addCar(car);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCarCubit, ProfileCarState>(
      listener: (context, state) {
        if (state is AddOrUpdateCarSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _isEditMode
                    ? S.of(context).carUpdatedSuccess
                    : S.of(context).carAddedSuccess,
                style: TextStyles.cairoRegular13,
              ),
              backgroundColor: AppColors.greenNormal,
            ),
          );
          Navigator.pop(context);
        } else if (state is AddOrUpdateCarFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg, style: TextStyles.cairoRegular13),
              backgroundColor: AppColors.redNormal,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddOrUpdateCarLoading,
          color: Colors.black,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.yellowNormal,
          ),
          child: Scaffold(
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).carInformation,
                        style: TextStyles.cairoBold20.copyWith(
                          color: AppColors.blueNormal,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.whiteLight,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.directions_car_filled_outlined,
                            color: AppColors.yellowNormal,
                            size: 48.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),

                       Align(
                        alignment: AlignmentGeometry.centerStart,
                         child: Text(
                            S.of(context).carBrand,
                            textAlign: TextAlign.start,
                            style: TextStyles.cairoBold16.copyWith(
                              color: AppColors.blueNormal,
                            ),
                                               ),
                       ),
                      SizedBox(height: 8.h),
                      CustomTextfeildWithBorder(
                        controller: _brandController,
                        hint: S.of(context).toyotaHint,
                        validator: AppValidator.validateEmpty,
                      ),
                      SizedBox(height: 20.h),

                       Align(
                        alignment: AlignmentGeometry.centerStart,
                         child: Text(
                            S.of(context).carModel,
                            style: TextStyles.cairoBold16.copyWith(
                              color: AppColors.blueNormal,
                            ),
                                               ),
                       ),
                      SizedBox(height: 8.h),
                      CustomTextfeildWithBorder(
                        controller: _modelController,
                        hint: S.of(context).camryHint,
                        validator: AppValidator.validateEmpty,
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).manufactureYear,
                                  style: TextStyles.cairoBold16.copyWith(
                                    color: AppColors.blueNormal,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomTextfeildWithBorder(
                                  controller: _yearController,
                                  hint: '2024',
                                  isNumber: true,
                                  validator: AppValidator.validateEmpty,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).plateNumber,
                                  style: TextStyles.cairoBold16.copyWith(
                                    color: AppColors.blueNormal,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomTextfeildWithBorder(
                                  controller: _plateController,
                                  hint: S.of(context).plateHint,
                                  validator: AppValidator.validateEmpty,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          S.of(context).carColor,
                          style: TextStyles.cairoBold16.copyWith(
                            color: AppColors.blueNormal,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _colorMap.entries.map((entry) {
                          final colorName = entry.key;
                          final colorVal = entry.value;
                          final isSelected = _selectedColor == colorName;
                          final isWhite = colorName == 'white';

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = colorName;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              padding: EdgeInsets.all(isSelected ? 2.w : 0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteLight,
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(
                                        color: AppColors.yellowNormal,
                                        width: 2.5,
                                      )
                                    : Border.all(
                                        color: isWhite
                                            ? AppColors.whiteNormalHover
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                              ),
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: colorVal,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.whiteNormalHover,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 32.h),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blueGrey,
                          borderRadius: CustomRadius.card12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              color: AppColors.blueNormal,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                S.of(context).privacyNote,
                                style: TextStyles.cairoRegular11.copyWith(
                                  color: AppColors.blueNormal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),

                      CustomElevatedButton(
                        text: _isEditMode
                            ? S.of(context).saveChanges
                            : S.of(context).addCar,
                        radius: CustomRadius.card,
                        fun: _submitForm,
                        backgColor: AppColors.blueNormal,
                        foregColor: AppColors.whiteLight,
                        height: 50,
                        fontStyle: TextStyles.cairoBold14,
                      ),
                      SizedBox(height: 16.h),

                      if (_isEditMode) ...[
                        CustomElevatedButton(
                          text: S.of(context).deleteCar,
                          radius: CustomRadius.card,
                          fun: () async {
                            final profileCarCubit = context
                                .read<ProfileCarCubit>();
                            final confirmed = await showDialog<bool>(
                              context: context,
                              barrierDismissible: false,
                              builder: (dialogCtx) => CustomAppDialog(
                                title: S.of(
                                  context,
                                ).deleteConfirmationTitle,
                                desc: S.of(
                                  context,
                                ).deleteConfirmationDesc,
                                btnText: S.of(context).cancel,
                                btnText2: S.of(
                                  context,
                                ).deleteBtn,
                                onTap: () => Navigator.of(dialogCtx).pop(false),
                                onTap2: () => Navigator.of(dialogCtx).pop(true),
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.whiteLight,
                                ),
                                iconBgColor: AppColors.redLightActive,
                                secondaryButtonColor: AppColors.redNormal,
                              ),
                            );
                            if (confirmed == true) {
                              if (_carId != null) {
                                profileCarCubit.deleteCar(_carId!);
                              }
                            }
                          },
                          backgColor: AppColors.redLightActive,
                          foregColor: AppColors.redDark,
                          height: 50,
                          fontStyle: TextStyles.cairoBold14,
                        ),
                        SizedBox(height: 12.h),
                      ],

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          S.of(context).cancel,
                          style: TextStyles.cairoBold16.copyWith(
                            color: AppColors.blueNormal,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
