import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/app_validator.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_textfeild_with_border.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  // bool _agreeToPrivacy = false;
  UserDataModel? currentUser;

  File? _selectedImage;
  bool _isImageDeleted = false;

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box<UserDataModel>('user_box');
    currentUser = userBox.get('user');

    _nameController = TextEditingController(text: currentUser?.name ?? '');
    _phoneController = TextEditingController(text: currentUser?.phone ?? '');
    _emailController = TextEditingController(text: currentUser?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickAndCropImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ), // مربع للبروفايل
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 85, // تصغير الحجم للحفاظ على السيرفر
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تعديل صورة البروفايل',
            toolbarColor: AppColors.blueNormal,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'تعديل الصورة', aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
          _isImageDeleted = false; // لو كان ماسحها واختار صورة جديدة
        });
      }
    } catch (e) {
      debugPrint("Error picking/cropping image: $e");
    }
  }

  // 3. ميثود إظهار الـ Bottom Sheet الخيارات (كاميرا - استوديو - مسح)
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Text(
                'صورة البروفايل',
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.photo_library_outlined,
                color: AppColors.yellowNormal,
              ),
              title: Text(
                'اختيار من المعرض',
                style: TextStyles.cairoBold14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickAndCropImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.yellowNormal,
              ),
              title: Text(
                'التقاط صورة بالكاميرا',
                style: TextStyles.cairoBold14.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickAndCropImage(ImageSource.camera);
              },
            ),
            if (_selectedImage != null ||
                (currentUser?.image.isNotEmpty ?? false))
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title:  Text(
                  'إزالة الصورة الحالية',
                  style: TextStyles.cairoBold14.copyWith(
                    color: AppColors.redNormal,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedImage = null;
                    _isImageDeleted = true;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _getProfileImage() {
    if (_isImageDeleted) return null;
    if (_selectedImage != null) return FileImage(_selectedImage!);

    if (currentUser != null && currentUser!.image.isNotEmpty) {
      return NetworkImage(
        currentUser!.image.startsWith('http')
            ? currentUser!.image
            : "${AppConstants.baseUrl}${currentUser!.image}",
      );
    }
    return null;
  }

  void _saveChanges() {
    if (currentUser == null) return;
    if (!_formKey.currentState!.validate()) return;

    context.read<UserCubitCubit>().updateUserInfo(
      // id: currentUser!.id,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      image: _selectedImage,
      removeImage: _isImageDeleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _getProfileImage();
    return BlocConsumer<UserCubitCubit, UserCubitState>(
      listener: (context, state) {
        if (state is UpdateUserInfoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم حفظ التغييرات بنجاح',
                style: TextStyles.cairoRegular13,
              ),
              backgroundColor: AppColors.greenNormal,
            ),
          );
          Navigator.pop(context);
        } else if (state is UpdateUserInfoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMsg, style: TextStyles.cairoRegular13),
              backgroundColor: AppColors.redNormal,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdateUserInfoLoading,
          color: Colors.black,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.yellowNormal,
          ),
          child: Scaffold(
            body: CustomScrollViewWithAppBar(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Text(
                'تعديل معلوماتك',
                style: TextStyles.cairoBold20.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 30.h),
              // ProfileAvatarWidget(
              //   imageUrl: currentUser?.image ?? '',
              //   onEditTap: () {},
              // ),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteLight,
                          width: 4.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            blurRadius: 8.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55.r,
                        backgroundColor: AppColors.yellowNormal,
                        backgroundImage: imageProvider,
                        child: imageProvider == null
                            ? Icon(
                                Icons.person,
                                size: 50.sp,
                                color: AppColors.yellowLight,
                              )
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          _showImageSourceOptions, // ربط الزرار هنا بالـ Bottom Sheet
                      child: CircleAvatar(
                        radius: 19.r,
                        backgroundColor: AppColors.whiteLight,
                        child: CircleAvatar(
                          radius: 17.r,
                          backgroundColor: AppColors.blueNormal,
                          child: Icon(
                            _isImageDeleted || imageProvider == null
                                ? Icons.add_a_photo_outlined
                                : Icons
                                      .edit_outlined, // يتغير الأيقونة لو الصورة موجودة
                            size: 19.sp,
                            color: AppColors.blueLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).fullName,
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfeildWithBorder(
                    controller: _nameController,
                    hint: S.of(context).fullName,
                    hintColor: AppColors.blueDarker,
                    validator: AppValidator.validateEmpty,
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الهاتف',
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfeildWithBorder(
                    controller: _phoneController,
                    // hint: 'رقم الهاتف',
                    isNumber: true,
                    readOnly: true,
                    prefixIcon: const Icon(
                      Icons.mobile_friendly_rounded,
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'البريد الإلكتروني',
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfeildWithBorder(
                    controller: _emailController,
                    hint: 'البريد الإلكتروني',
                    hintColor: AppColors.blueDarker,
                    validator: AppValidator.validateEmail,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.blueNormal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                        'تتم معالجة جميع بياناتك الشخصية وتخزينها بشكل آمن وفقاً لسياسة الخصوصية الخاصة بنا',
                        style: TextStyles.cairoRegular11.copyWith(
                          color: AppColors.blueNormal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              CustomElevatedButton(
                text: 'حفظ التغييرات',
                radius: CustomRadius.card,
                fun: _saveChanges,
                backgColor: AppColors.blueNormal,
                foregColor: AppColors.whiteLight,
                height: 50,
                fontStyle: TextStyles.cairoBold16,
              ),
              SizedBox(height: 12.h),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'إلغاء',
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ),
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
