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
import 'package:motoverse/generated/l10n.dart';

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

  late final List<TagModel> _tags;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tags = [
      TagModel(nameAr: S.of(context).fastResponse, nameEn: "fast_response"),
      TagModel(
        nameAr: S.of(context).excellentManner,
        nameEn: "excellent_manner",
      ),
      TagModel(nameAr: S.of(context).professional, nameEn: "professional"),
      TagModel(nameAr: S.of(context).helpful, nameEn: "helpful"),
      TagModel(
        nameAr: S.of(context).needsImprovement,
        nameEn: "needs_improvement",
      ),
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.cairoMedium12.copyWith(color: AppColors.whiteLight),
          textAlign: TextAlign.center,
        ),
        backgroundColor: isError ? AppColors.redNormal : AppColors.blueNormal,
        duration: Duration(seconds: isError ? 3 : 2),
      ),
    );
  }

  void _navigateToMain() {
    context.read<NavigationProvider>().changeIndex(0);
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('main screen', (route) => false);
  }

  void _toggleTag(TagModel tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        if (_selectedTags.length < 3) {
          _selectedTags.add(tag);
        } else {
          _showSnackBar(S.of(context).maxTagsWarning);
        }
      }
    });
  }

  void _submitReview() {
    final List<String> tagsToSend = _selectedTags.map((e) => e.nameEn).toList();

    context.read<ReviewCubit>().submitReview(
      offerId: widget.offerId,
      rating: _selectedRating,
      comment: _commentController.text.trim(),
      tags: tagsToSend,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccess) {
          _showSnackBar(S.of(context).reviewSubmittedSuccessfully);
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) _navigateToMain();
          });
        } else if (state is ReviewFailure) {
          _showSnackBar(state.errorMessage, isError: true);
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
                S.of(context).orderCompletedSuccessfully,
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                S.of(context).experienceQuestion,
                style: TextStyles.cairoBold16.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final int starValue = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = starValue;
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
                  S.of(context).addComment,
                  style: TextStyles.cairoBold16.copyWith(
                    color: AppColors.blueNormal,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextfeildWithBorder(
                controller: _commentController,
                hint: S.of(context).commentHint,
                maxLines: 4,
                validator: (value) => null,
              ),
              SizedBox(height: 40.h),

              BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  final isLoading = state is ReviewLoading;
                  return CustomElevatedButton(
                    text: isLoading
                        ? S.of(context).submitting
                        : S.of(context).submitReview,
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
                onTap: _navigateToMain,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    S.of(context).skip,
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
                        S.of(context).safetyNotice,
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
