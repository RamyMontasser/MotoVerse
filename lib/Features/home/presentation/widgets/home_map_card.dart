import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class HomeMapCard extends StatelessWidget {
  const HomeMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      builder: (context, state) {
        LatLng centerLatLng = const LatLng(30.0444, 31.2357);
        bool isLocationLoaded = false;
        int centersCount = 0;

        if (state is CurrentLocationSuccess) {
          centerLatLng = LatLng(
            state.currentLocation.latitude,
            state.currentLocation.longitude,
          );
          isLocationLoaded = true;
          centersCount = state.nearestCentersCount;
        }

        return Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                Positioned.fill(
                  child: FlutterMap(
                    key: ValueKey(
                      '${centerLatLng.latitude}_${centerLatLng.longitude}',
                    ),
                    options: MapOptions(
                      initialCenter: centerLatLng,
                      initialZoom: 14.0,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: AppConstants.mapBoxTemp,
                        additionalOptions: {
                          'accessToken': AppConstants.mapBoxToken,
                          'id': AppConstants.mapBoxMapId,
                        },
                        subdomains: const ['a', 'b', 'c', 'd'],
                        userAgentPackageName: 'com.example.motoverse',
                      ),
                      if (isLocationLoaded)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: centerLatLng,
                              width: 40.w,
                              height: 40.h,
                              child: SvgPicture.asset(
                                'assets/icons/map/ic_Pin.svg',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 60.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withAlpha(150),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15.h,
                  right: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).findNearbyCenters,
                        style: TextStyles.cairoBold12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        isLocationLoaded
                            ? (centersCount != 0
                                  ? S
                                        .of(context)
                                        .exploreNearbyCentersCount(centersCount)
                                  : S.of(context).noNearbyCenters)
                            : S.of(context).locatingNearbyCenters,
                        style: TextStyles.reg10Tajawal.copyWith(
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
