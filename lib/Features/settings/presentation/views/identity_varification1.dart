import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_dialog.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/settings/data/models/identity_feild_model.dart';
import 'package:motoverse/Features/settings/data/repo/settings_repo.dart';
import 'package:motoverse/Features/settings/presentation/cubit/identity_verification_cubit.dart';
import 'package:motoverse/Features/settings/presentation/widgets/identity_picker_card.dart';

class IdentityVarification extends StatefulWidget {
  const IdentityVarification({super.key});

  @override
  State<IdentityVarification> createState() => _IdentityVarificationState();
}

class _IdentityVarificationState extends State<IdentityVarification> {
  final List<IdentityFieldModel> _verificationFields = [
    IdentityFieldModel(
      id: 1,
      title: "تصوير البطاقة الشخصية من الأمام",
      iconPath: Icons.file_upload_outlined,
    ),
    IdentityFieldModel(
      id: 2,
      title: "تصوير البطاقة الشخصية من الخلف",
      iconPath: Icons.file_upload_outlined,
    ),
    IdentityFieldModel(
      id: 3,
      title: "تصوير صورة واضحة للوجه",
      iconPath: Icons.add_a_photo_outlined,
    ),
  ];

  final Map<int, XFile?> _pickedImages = {1: null, 2: null, 3: null};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdentityVerificationCubit(getIt<SettingsRepo>()),
      child: BlocConsumer<IdentityVerificationCubit, IdentityVerificationState>(
        listener: (context, state) {
          if (state is IdentityVerificationLoading) {
            CustomDialog.show(context: context, isSuccess: false);
          } else if (state is IdentityVerificationSuccess) {
            Navigator.pop(context); // Pop loading dialog
            CustomDialog.show(context: context, isSuccess: true);

            
          } else if (state is IdentityVerificationFailure) {
            Navigator.pop(context); // Pop loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.yellowLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: AppColors.yellowNormal,
                          size: 65.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "نحتاج تأكيد هويتك",
                      style: TextStyles.cairoBold24.copyWith(
                        color: AppColors.blueNormal,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'لتوفير تجربة آمنة وموثقة\n لمستخدمين motoverse',
                      style: TextStyles.cairoRegular14.copyWith(
                        color: AppColors.whiteDarkActive,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _verificationFields.length,
                      itemBuilder: (context, index) {
                        return IdentityPickerCard(
                          field: _verificationFields[index],
                          onCardTap: (image) {
                            setState(() {
                              _pickedImages[index + 1] = image;
                            });
                          },
                          pickedImage: _pickedImages[index + 1],
                        );
                      },
                    ),
                    CustomElevatedButton(
                      text: 'تأكيد الهوية',
                      radius: CustomRadius.card12,
                      fun: () async {
                        if (_pickedImages[1] != null &&
                            _pickedImages[2] != null &&
                            _pickedImages[3] != null) {
                          context.read<IdentityVerificationCubit>().verifyIdentity(
                                frontId: _pickedImages[1]!,
                                backId: _pickedImages[2]!,
                                faceImage: _pickedImages[3]!,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى تحميل جميع الصور المطلوبة'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      height: 50,
                      fontStyle: TextStyles.cairoBold16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
