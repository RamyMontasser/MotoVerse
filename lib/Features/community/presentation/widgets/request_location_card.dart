import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/presentation/widgets/user_listtile.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/generated/l10n.dart';

class RequestLocationCard extends StatelessWidget {
  const RequestLocationCard({
    super.key,
    this.isAccepted,
    required this.request,
    this.offer,
  });

  final bool? isAccepted;
  final RequestModel request;
  final OfferModel? offer;

  @override
  Widget build(BuildContext context) {
    debugPrint(request.distance.toString());
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      builder: (context, state) {
        LatLng? currentLatLng;
        if (state is CurrentLocationSuccess) {
          currentLatLng = LatLng(
            state.currentLocation.latitude,
            state.currentLocation.longitude,
          );
        }
        LatLng requestLatLng = LatLng(
          request.location?.latitude ?? 31.415,
          request.location?.longitude ?? 31.814,
        );

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.whiteLight,
            borderRadius: CustomRadius.r20,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: isAccepted == true ? 161.h : 106.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: requestLatLng,
                      initialZoom: 13.0,
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
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: requestLatLng,
                            child: SvgPicture.asset(
                              'assets/icons/map/blue_pin.svg',
                            ),
                          ),
                          if (currentLatLng != null)
                            Marker(
                              point: currentLatLng,
                              child: SvgPicture.asset(
                                'assets/icons/map/ic_Pin.svg',
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isAccepted == true ? 5.h : 15.h),
              if (isAccepted == true)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).distanceAndTime,
                            style: TextStyles.cairoBold12.copyWith(
                              color: AppColors.whiteDarker,
                            ),
                          ),
                          Text(
                            S
                                .of(context)
                                .distanceAndMinutes(
                                  request.distance ?? 0,
                                  offer?.estimatedMinutes ?? 0,
                                ),
                            style: TextStyles.cairoBold16.copyWith(
                              color: AppColors.blueNormal,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                UserListtile(request: request),
            ],
          ),
        );
      },
    );
  }
}
