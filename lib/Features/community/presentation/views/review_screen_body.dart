import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_textfeild_with_border.dart';
import 'package:motoverse/Features/community/data/models/tag_model.dart';
import 'package:motoverse/Features/community/presentation/cubit/review_cubit.dart';
import 'package:motoverse/Features/community/presentation/widgets/helper_contact.dart';

class ReviewScreenBody extends StatefulWidget {
  final int offerId;
  final String helperName;
  final String? helperAvatar;
  final String otherUserId;
  final String averageRating;

  const ReviewScreenBody({
    super.key,
    required this.offerId,
    required this.helperName,
    required this.helperAvatar,
    required this.otherUserId,
    required this.averageRating,
  });

  @override
  State<ReviewScreenBody> createState() => _ReviewScreenBodyState();
}

class _ReviewScreenBodyState extends State<ReviewScreenBody> {
  int _selectedRating = 1;
  final List<TagModel> _selectedTags = [];
  final TextEditingController _commentController = TextEditingController();

  final List<TagModel> _tags = [
    TagModel(nameAr: "سريع الاستجابة", nameEn: "fast_response"),
    TagModel(nameAr: "تعامل ممتاز", nameEn: "excellent_manner"),
    TagModel(nameAr: "محترف", nameEn: "professional"),
    TagModel(nameAr: "مفيد", nameEn: "helpful"),
    TagModel(nameAr: "يحتاج تحسين", nameEn: "needs_improvement"),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleTag(TagModel tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        if (_selectedTags.length < 3) {
          _selectedTags.add(tag);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'يمكنك اختيار ثلاثة صفات فقط كحد أقصى',
                style: TextStyles.cairoMedium12.copyWith(
                  color: AppColors.whiteLight,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColors.blueNormal,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  void _submitReview() {
    List<String> tagsToSend = _selectedTags.map((e) => e.nameEn).toList();

    context.read<ReviewCubit>().submitReview(
      offerId: widget.offerId,
      rating: _selectedRating,
      comment: _commentController.text,
      tags: tagsToSend,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم إرسال تقييمك بنجاح!',
                style: TextStyles.cairoMedium12.copyWith(
                  color: AppColors.whiteLight,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColors.blueNormal,
              duration: const Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.read<NavigationProvider>().changeIndex(0);
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('main screen', (route) => false);
            }
          });
        } else if (state is ReviewFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: TextStyles.cairoMedium12.copyWith(
                  color: AppColors.whiteLight,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColors.redNormal,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.yellowLight,
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  color: AppColors.yellowNormal,
                  size: 55.sp,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'تم إنهاء الطلب بنجاح',
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              // SizedBox(height: 24.h),

              // HelperContact(
              //   helperName: widget.helperName,
              //   helperAvatar: widget.helperAvatar,
              //   averageRating: widget.averageRating,
              // ),
              SizedBox(height: 32.h),

              Text(
                'كيف كانت تجربتك مع مقدم المساعدة؟',
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        index < _selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.yellowNormal,
                        size: 36.sp,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 24.h),

              Wrap(
                spacing: 8.w,
                runSpacing: 10.h,
                alignment: WrapAlignment.center,
                children: _tags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return GestureDetector(
                    onTap: () => _toggleTag(tag),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.blueLight
                            : AppColors.whiteLight,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.blueNormal
                              : AppColors.blueLightHover,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag.nameAr,
                        style: TextStyles.cairoRegular14.copyWith(
                          color: isSelected
                              ? AppColors.blueNormal
                              : AppColors.whiteDarker,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 32.h),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'أضف تعليقًا',
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              CustomTextfeildWithBorder(
                controller: _commentController,
                hint: 'شارك تجربتك لمساعدة المستخدمين الآخرين',
                maxLines: 4,
                validator: (value) => null,
              ),
              SizedBox(height: 40.h),

              BlocBuilder<ReviewCubit, ReviewState>(
                buildWhen: (previous, current) => current is ReviewLoading,
                builder: (context, state) {
                  final isLoading = state is ReviewLoading;
                  return CustomElevatedButton(
                    text: isLoading ? 'جاري الإرسال...' : 'ارسال التقييم',
                    radius: BorderRadius.circular(12.r),
                    backgColor: AppColors.yellowNormal,
                    foregColor: AppColors.whiteLight,
                    height: 52,
                    fontStyle: TextStyles.cairoBold16,
                    fun: isLoading ? null : _submitReview,
                  );
                },
              ),
              SizedBox(height: 16.h),

              GestureDetector(
                onTap: () {
                  context.read<NavigationProvider>().changeIndex(0);
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('main screen', (route) => false);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'تخطي',
                    style: TextStyles.cairoBold16.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: CustomRadius.r1,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 24.sp,
                      color: AppColors.blueNormal,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'طلبك مؤمن ومدعوم بضمان Motoverse Safety.',
                        style: TextStyles.cairoRegular14.copyWith(
                          color: AppColors.blueNormal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
