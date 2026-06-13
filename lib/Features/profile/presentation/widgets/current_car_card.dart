import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/profile/data/models/car_model.dart';
import 'package:motoverse/Features/profile/presentation/cubit/profile_car_cubit.dart';
import 'package:motoverse/Features/profile/presentation/views/add_or_update_car_screen.dart';
import 'package:motoverse/generated/l10n.dart'; 

class CurrentCarCard extends StatelessWidget {
  final CarModel? car;

  const CurrentCarCard({super.key, this.car});

  @override
  Widget build(BuildContext context) {
    final hasCar = car != null;

    return InkWell(
      onTap: () {
        final profileCarCubit = context.read<ProfileCarCubit>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: profileCarCubit,
              child: const AddOrUpdateCarScreen(),
            ),
            settings: RouteSettings(arguments: car),
          ),
        ).then((_) {
          profileCarCubit.fetchCars();
        });
      },
      borderRadius: CustomRadius.card12,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.whiteLight,
          borderRadius: CustomRadius.card12,
          border: Border.all(color: AppColors.whiteNormalHover),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: hasCar ? AppColors.blueLight : AppColors.whiteNormal,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.directions_car_filled_outlined,
                color: hasCar ? AppColors.blueNormal : AppColors.whiteDark,
                size: 30.sp,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).currentCar, 
                    style: TextStyles.cairoBold12.copyWith(
                      color: AppColors.yellowNormal,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    hasCar
                        ? '${car!.brand} ${car!.model} ${car!.year}'
                        : S
                              .of(context)
                              .noCarRegistered, 
                    style: TextStyles.cairoBold16.copyWith(
                      color: hasCar
                          ? AppColors.blueNormal
                          : AppColors.whiteDarker,
                    ),
                  ),
                  if (hasCar) ...[
                    SizedBox(height: 1.h),
                    Text(
                      S
                          .of(context)
                          .plateNumberLabel(
                            car!.plateNumber,
                          ), 
                      style: TextStyles.cairoRegular13.copyWith(
                        color: AppColors.whiteDarker,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (hasCar)
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: AppColors.whiteNormalHover,
              ),
          ],
        ),
      ),
    );
  }
}
