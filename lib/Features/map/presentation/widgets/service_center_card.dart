import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';
import 'package:provider/provider.dart';

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
  final MapController mapController;

  // String get _secureImageUrl {
  //   return image.startsWith('http://')
  //       ? image.replaceFirst('http://', 'https://')
  //       : image;
  // }

  @override
  Widget build(BuildContext context) {
    // debugPrint('the image :  $image');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: CustomRadius.card,
        color: AppColors.whiteLight,
        border: BoxBorder.all(color: AppColors.whiteDark, width: 0.5),
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
                  child: 
                  // CachedNetworkImage(
                  //   imageUrl: image,
                  //   fit: BoxFit.cover,
                  //   width: 40.w,
                  //   height: 40.h,
                  //   placeholder: (context, url) =>
                  //       Center(child: CircularProgressIndicator(
                  //         color: AppColors.yellowNormal,
                  //       )),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // )

                  Image.network(
                    image,fit: BoxFit.cover,
                    headers: {"Accept": "image/*"},
                    width: 40.w,
                    height: 80.h,
                    errorBuilder: (context, error, stackTrace) {
                      // debugPrint('$error');
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
                        child: Center(child: CircularProgressIndicator(
                          color: AppColors.yellowNormal,
                        )),
                      );
                    },
                  ),
                
                  // SvgPicture.asset(
                  //   'assets/images/onboarding/Frame1.svg',
                  //   fit: BoxFit.cover,
                  //   width: 100.w,
                  //   height: 90.h,
                  // ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyles.cairoRegular16.copyWith(
                            color: AppColors.blueDarkHover,
                          ),
                        ),
                        Spacer(),

                        Icon(Icons.bookmark_border, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "(120+ reviews)",
                            style: TextStyles.cairoRegular11.copyWith(
                              color: AppColors.whiteDarkHover,
                            ),
                          ),

                          const TextSpan(text: "  "),

                          TextSpan(
                            text: "$averageRating ",
                            style: TextStyles.med13Tajawal,
                          ),

                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...services.map((service) => _buildTag(
                            service.name,
                          )),
                        // _buildTag("فرامل"),
                        // _buildTag("إطارات"),
                        // _buildTag("تغيير زيت"),
                      ],
                    ),),

                    SizedBox(height: 6.h),

                    Row(
                      children: [
                        buildIconText(
                          text: "${openingTime.substring(0,5)} - ${closingTime.substring(0,5)}",
                          icon: Icons.access_time,
                          color: AppColors.greenNormal,
                        ),

                        buildIconText(
                          text: "$distanceKm كم",
                          icon: Icons.location_on_outlined,
                          color: AppColors.whiteDarkHover,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // const Spacer(),
              
            ],
          ),

          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomElevatedButton(
                  text: "الاتجاهات",
                  radius: CustomRadius.r2,
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
                  width: 100.w,
                  height: 40.h,
                  suffixIcon: Icon(Icons.directions_outlined),
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    backgroundColor: AppColors.blueLight,
                    foregroundColor: AppColors.blueNormal,
                    shape: RoundedRectangleBorder(
                      borderRadius: CustomRadius.r2,
                    ),
                  ),
                  icon: Icon(Icons.phone_outlined),
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                flex: 2,
                child: CustomElevatedButton(
                  text: "احجز الآن",
                  radius: CustomRadius.r2,
                  fun: () {},
                  withBorder: false,
                  fontStyle: TextStyles.cairoSemiBold16,
                  backgColor: AppColors.blueLight,
                  foregColor: AppColors.blueNormal,
                  width: 70,
                  height: 40,
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
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
      padding: EdgeInsets.only(right: 12.w, left: 12.w),
      child: Text.rich(
        TextSpan(
          children: [
            if (iconLeading) ...[
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(icon, color: color, size: 10.w),
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
                child: Icon(icon, color: color, size: 10.w),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget _buildActionButton(
  //   String label,
  //   Color bg,
  //   Color text, {
  //   IconData? icon,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 10.h),
  //     decoration: BoxDecoration(
  //       color: bg,
  //       borderRadius: BorderRadius.circular(8.r),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         if (icon != null) Icon(icon, color: text, size: 18.sp),
  //         if (icon != null) SizedBox(width: 4.w),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             color: text,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 12.sp,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildIconButton(IconData icon) {
  //   return Container(
  //     padding: EdgeInsets.all(10.w),
  //     decoration: BoxDecoration(
  //       color: Colors.blue.shade50,
  //       borderRadius: BorderRadius.circular(8.r),
  //     ),
  //     child: Icon(icon, color: Colors.blue, size: 20.sp),
  //   );
  // }
}
