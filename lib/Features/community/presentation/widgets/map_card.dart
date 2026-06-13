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
import 'package:motoverse/generated/l10n.dart';

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
            color: AppColors.whiteLight,
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
                                point: userPos != null
                                    ? LatLng(
                                        userPos.latitude,
                                        userPos.longitude,
                                      )
                                    : const LatLng(
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
                                SnackBar(
                                  content: Text(
                                    S.of(context).locatingUserMessage,
                                  ),
                                ),
                              );
                            }
                          },
                          backgroundColor: AppColors.whiteLight,
                          child: SvgPicture.asset(
                            'assets/icons/map/gps.svg',
                            width: 21.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blueNormal,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.isDone)
                ListTile(
                  title: Text(
                    S.of(context).findNearbyCentersTitle,
                    style: TextStyles.cairoBold13.copyWith(
                      color: AppColors.blueNormal,
                    ),
                  ),
                  subtitle: Text(
                    S.of(context).findNearbyCentersSubtitle,
                    style: TextStyles.cairoRegular11.copyWith(
                      color: AppColors.blueDark,
                    ),
                  ),
                  trailing: const Icon(
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
