import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';

class MapCard extends StatefulWidget {
  const MapCard({super.key, required this.isDone});
  final bool isDone;

  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      // listener: (context, state) {
      //   if (state is CurrentLocationSuccess) {
      //     WidgetsBinding.instance.addPostFrameCallback((_) {
      //       context.read<CurrentLocationCubit>().moveToCurrentPosition(
      //         state.currentLocation.latitude,
      //         state.currentLocation.longitude,
      //       );
      //     });
      //   }
      // },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final cubit = context.read<CurrentLocationCubit>();
        LatLng? userPos;

        if (state is CurrentLocationSuccess) {
          userPos = LatLng(
            state.currentLocation.latitude,
            state.currentLocation.longitude,
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.whiteNormalActive),
            boxShadow: [
              BoxShadow(
                color: AppColors.blueDarker.withAlpha(30),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: widget.isDone ? 106.h : 161.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: userPos != null
                              ? LatLng(userPos.latitude, userPos.longitude)
                              : const LatLng(24.7136, 46.6753),
                          keepAlive: true,
                          initialZoom: 15.0,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.all,
                          ),
                          // onMapReady: () {
                          //       final pos = cubit.lastKnownPosition;
                          //       if (pos != null) {
                          //         WidgetsBinding.instance.addPostFrameCallback((_) {
                          //           cubit.moveToCurrentPosition(
                          //             pos.latitude,
                          //             pos.longitude,
                          //           );
                          //         });
                          //       }
                          //     },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: AppConstants.mapBoxTemp,
                            additionalOptions: {
                              'accessToken': AppConstants.mapBoxToken,
                              'id': AppConstants.mapBoxMapId,
                            },
                            subdomains: ['a', 'b', 'c', 'd'],
                            userAgentPackageName: 'com.example.motoverse',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: userPos != null
                                    ? LatLng(
                                        userPos.latitude,
                                        userPos.longitude,
                                      )
                                    : LatLng(
                                        31.41285350124312,
                                        31.80483832922779,
                                      ),
                                width: 40,
                                height: 40,
                                child: SvgPicture.asset(
                                  'assets/icons/map/ic_Pin.svg',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!widget.isDone)
                      Positioned(
                        bottom: 12.h,
                        right: 12.w,
                        child: FloatingActionButton(
                          heroTag: null,
                          mini: true,
                          onPressed: () {
                            if (userPos != null) {
                              cubit.moveToCurrentPosition(
                                userPos.latitude,
                                userPos.longitude,
                                mapController: _mapController,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'جاري تحديد موقعك، انتظر لحظة...',
                                  ),
                                ),
                              );
                            }
                          },
                          backgroundColor: AppColors.whiteLight,
                          // foregroundColor: AppColors.blueNormal,
                          child: SvgPicture.asset(
                            'assets/icons/map/gps.svg',
                            width: 21.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blueNormal,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),

                        //  Container(
                        //   width: 44.w,
                        //   height: 44.h,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     shape: BoxShape.circle, // جعل الحاوية دائرية
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.black.withOpacity(0.1),
                        //         blurRadius: 8,
                        //         offset: const Offset(0, 4),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.explore, // أيقونة البوصلة
                        //       color: AppColors.blueNormal, // اللون الأزرق من ثيم التطبيق
                        //       size: 24.sp,
                        //     ),
                        //   ),
                        // ),
                      ),
                  ],
                ),
              ),
              if (widget.isDone)
                ListTile(
                  // contentPadding: EdgeInsets.symmetric(
                  //   vertical: 4.h,
                  // ),
                  title: Text(
                    'اعثر على مراكز صيانة قريبة',
                    style: TextStyles.cairoBold13.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  subtitle: Text(
                    'استكشف أكثر من 24 مركزاً',
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.blueDark,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blueNormal,
                    size: 20,
                  ),
                  onTap: () {},
                ),
            ],
          ),
        );
      },
    );
  }
}
