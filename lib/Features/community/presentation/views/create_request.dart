import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_textfeild_with_border.dart';
import 'package:motoverse/Features/community/data/models/problem_type_model.dart';
import 'package:motoverse/Features/community/data/models/create_request_model.dart';
import 'package:motoverse/Features/community/presentation/widgets/images_list.dart';
import 'package:motoverse/Features/community/presentation/widgets/map_card.dart';
import 'package:motoverse/Features/community/presentation/widgets/problem_types_grid.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/presentation/cubit/create_request_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/history/presentation/widgets/bottom_sheet_button.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedProblemIndex;
  final List<ProblemTypeModel> _problemTypes = [
    ProblemTypeModel(
      title: "بطارية",
      titleEnglish: "battery",
      iconPath: 'assets/icons/community/battery.svg',
    ),
    ProblemTypeModel(
      title: "محرك",
      titleEnglish: "engine",
      iconPath: 'assets/icons/community/motor.svg',
    ),
    ProblemTypeModel(
      title: "الإطارات",
      titleEnglish: "tires",
      iconPath: 'assets/icons/community/wheels.svg',
    ),
    ProblemTypeModel(
      title: "غير ذلك",
      titleEnglish: "other",
      iconPath: 'assets/icons/community/other.svg',
    ),
  ];

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CurrentLocationCubit>().getCurrentLocation();
      }
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  List<XFile> pickedImages = [];

  @override
  Widget build(BuildContext context) {
    final bool isOffLine = ModalRoute.of(context)!.settings.arguments as bool;
    return BlocProvider(
      create: (context) =>
          CreateRequestCubit(communityRepo: getIt<CommunityRepo>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CustomScrollViewWithAppBar(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isOffLine
                                ? const MapCard(isDone: false)
                                : const SizedBox(),
                            SizedBox(height: 15.h),

                            Text(
                              "نوع المشكلة",
                              style: TextStyles.cairoBold18.copyWith(
                                color: AppColors.blueDarkActive,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            ProblemTypesGrid(
                              selectedIndex: _selectedProblemIndex,
                              problemTypes: _problemTypes,
                              onChoose: (index) {
                                setState(() {
                                  _selectedProblemIndex = index;
                                });
                              },
                            ),

                            SizedBox(height: 30.h),

                            Text(
                              "وصف المشكلة",
                              style: TextStyles.cairoBold18.copyWith(
                                color: AppColors.blueDarkActive,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            CustomTextfeildWithBorder(
                              controller: _descriptionController,
                              hint: "اوصف المشكلة التي تواجهك",
                              maxLines: 5,
                            ),
                            SizedBox(height: 30.h),

                            Text(
                              'اضافة صور',
                              style: TextStyles.cairoBold18.copyWith(
                                color: AppColors.blueDarkActive,
                              ),
                            ),
                            SizedBox(height: 15.h),

                            ImagesList(
                              onImagePicked: (image) {
                                setState(() {
                                  pickedImages.add(image);
                                });
                              },
                              onDelete: (imageIndex) {
                                setState(() {
                                  pickedImages.removeAt(imageIndex);
                                });
                              },
                              pickedImages: pickedImages,
                            ),

                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blueLight,
                                borderRadius: CustomRadius.r1,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    size: 16.sp,
                                    color: AppColors.blueNormal,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "يتم تخزين صورك وبياناتك بأمان",
                                    style: TextStyles.cairoRegular11.copyWith(
                                      color: AppColors.blueNormal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 150.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<CreateRequestCubit, CreateRequestState>(
                  listener: (context, state) {
                    if (state is CreateRequestSuccess) {
                      Navigator.of(context).pushNamed('RequestDone');
                    } else if (state is CreateRequestFail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CreateRequestLoading) {
                      debugPrint(isOffLine.toString());
                      return Container(
                        color: AppColors.whiteLight,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blueNormal,
                          ),
                        ),
                      );
                    }
                    return BottomSheetButton(
                      text: 'طلب المساعدة',
                      fun: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (_selectedProblemIndex == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('الرجاء اختيار نوع المشكلة'),
                            ),
                          );
                          return;
                        }

                        double? lat;
                        double? lng;
                        String? city;
                        final locationState = context
                            .read<CurrentLocationCubit>()
                            .state;
                        if (locationState is CurrentLocationSuccess) {
                          lat = locationState.currentLocation.latitude;
                          lng = locationState.currentLocation.longitude;
                          city = locationState.cityName;
                        }

                        context.read<CreateRequestCubit>().createRequest(
                          CreateRequestModel(
                            description: _descriptionController.text,
                            problemType:
                                _problemTypes[_selectedProblemIndex!]
                                    .titleEnglish ??
                                "",
                            requestType: isOffLine ? "offline" : "online",
                            latitude: isOffLine ? lat : null,
                            longitude: isOffLine ? lng : null,
                            // city: "asdf",
                            city: city,
                            images: pickedImages,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
