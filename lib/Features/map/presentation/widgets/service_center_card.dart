import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCenterCard extends StatelessWidget {
  const ServiceCenterCard({
    super.key,
    required this.lat,
    required this.lng,
    required this.name,
    required this.image,
    required this.services,
    required this.openingTime,
    required this.closingTime,
    required this.averageRating,
    required this.distanceKm,
    required this.phone,
    required this.mapController,
  });

  final double lat;
  final double lng;
  final String name;
  final String image;
  final List<ServiceModel> services;
  final String openingTime;
  final String closingTime;
  final double averageRating;
  final double distanceKm;
  final String? phone;
  final MapController mapController;

  String get _imageUrl {
    if (image.startsWith('http')) return image;
    final separator = image.startsWith('/') ? '' : '/';
    return '${AppConstants.baseUrl}$separator$image';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: CustomRadius.card,
        color: AppColors.whiteLight,
        border: Border.all(
          color: AppColors.whiteDark,
          width: 0.5,
        ), 
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDarker.withAlpha(30),
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    _imageUrl,
                    fit: BoxFit.cover,
                    headers: const {"Accept": "image/*"},
                    width: 40.w,
                    height: 80.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40.w,
                        height: 80.h,
                        color: AppColors.whiteDark,
                        child: const Icon(
                          Icons.broken_image,
                          color: AppColors.whiteDarker,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 40.w,
                        height: 80.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellowNormal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyles.cairoRegular16.copyWith(
                        color: AppColors.blueDarkHover,
                      ),
                    ),
                    // SizedBox(height: 2.h),
                    // Text.rich(
                    //   TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: "(120+ reviews)",
                    //         style: TextStyles.cairoRegular11.copyWith(
                    //           color: AppColors.whiteDarkHover,
                    //         ),
                    //       ),
                    //       const TextSpan(text: "  "),
                    //       TextSpan(
                    //         text: "$averageRating ",
                    //         style: TextStyles.med13Tajawal,
                    //       ),
                    //       WidgetSpan(
                    //         alignment: PlaceholderAlignment.middle,
                    //         child: Icon(
                    //           Icons.star,
                    //           color: Colors.amber,
                    //           size: 16.sp,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: services
                            .map((service) => _buildTag(service.name))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 6.h),

                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: buildIconText(
                            text:
                                "${openingTime.substring(0, 5)} - ${closingTime.substring(0, 5)}",
                            icon: Icons.access_time,
                            color: AppColors.greenNormal,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: buildIconText(
                            text: "$distanceKm كم",
                            icon: Icons.location_on_outlined,
                            color: AppColors.whiteDarkHover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: "الاتجاهات",
                  radius: CustomRadius.r1,
                  fun: () {
                    context.read<CurrentLocationCubit>().moveToCurrentPosition(
                      lat,
                      lng,
                      mapController: mapController,
                    );
                  },
                  withBorder: false,
                  fontStyle: TextStyles.cairoSemiBold16,
                  backgColor: AppColors.blueNormal,
                  foregColor: AppColors.whiteLight,
                  suffixIcon: const Icon(Icons.directions_outlined),
                  height: 46,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: IconButton(
                  onPressed: (phone?.isNotEmpty ?? false)
                      ? () async {
                          final phoneNumber = phone ?? '';
                          final uri = Uri(scheme: 'tel', path: phoneNumber);
                          await launchUrl(uri);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 10.h,
                    ),
                    backgroundColor: AppColors.blueLight,
                    foregroundColor: AppColors.blueNormal,
                    shape: RoundedRectangleBorder(
                      borderRadius: CustomRadius.r1,
                    ),
                  ),
                  icon: const Icon(Icons.phone_outlined),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.blueLightHover,
        borderRadius: CustomRadius.r2,
      ),
      child: Text(
        label,
        style: TextStyles.cairoMedium12.copyWith(
          color: AppColors.blueDarkActive,
        ),
      ),
    );
  }

  Widget buildIconText({
    required String text,
    required IconData icon,
    required Color color,
    bool iconLeading = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text.rich(
        maxLines: 1, 
        overflow: TextOverflow
            .ellipsis, 
        TextSpan(
          children: [
            if (iconLeading) ...[
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  icon,
                  color: color,
                  size: 12.w,
                ), 
              ),
              const TextSpan(text: " "),
            ],
            TextSpan(
              text: text,
              style: TextStyles.med13Tajawal.copyWith(color: color),
            ),
            if (!iconLeading) ...[
              const TextSpan(text: " "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(icon, color: color, size: 12.w),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
