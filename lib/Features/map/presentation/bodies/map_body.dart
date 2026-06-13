import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/widgets/custom_search.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/map/data/models/service_center_model.dart';
import 'package:motoverse/Features/map/presentation/cubit/service_center_cubit.dart';
import 'package:motoverse/Features/map/presentation/widgets/service_center_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:motoverse/generated/l10n.dart';

class MapBody extends StatefulWidget {
  const MapBody({super.key, this.currentPosition});
  final Position? currentPosition;

  @override
  State<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  TextEditingController search = TextEditingController();
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    search.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrentLocationCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<CurrentLocationCubit, CurrentLocationState>(
          listener: (context, state) {
            if (state is CurrentLocationSuccess) {
              _mapController.move(
                LatLng(
                  state.currentLocation.latitude,
                  state.currentLocation.longitude,
                ),
                15.0,
              );
            }
          },
        ),
        BlocListener<ServiceCenterCubit, ServiceCenterState>(
          listener: (context, state) {
            if (state is ServiceCenterDetailsSuccess) {
              _showServiceCenterDetails(context, state.serviceCenter);
            }
            if (state is ServiceCenterDetailsFail) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
        ),
      ],
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 160,
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.currentPosition != null
                    ? LatLng(
                        widget.currentPosition!.latitude,
                        widget.currentPosition!.longitude,
                      )
                    : LatLng(31.41285350124312, 31.81483832922779),
                initialZoom: 16.0,
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
                  tileProvider: NetworkTileProvider(),
                ),
                BlocBuilder<ServiceCenterCubit, ServiceCenterState>(
                  builder: (context, state) {
                    List<Marker> markers = [
                      Marker(
                        point: widget.currentPosition != null
                            ? LatLng(
                                widget.currentPosition!.latitude,
                                widget.currentPosition!.longitude,
                              )
                            : LatLng(31.41285350124312, 31.80483832922779),
                        width: 50,
                        height: 50,
                        child: SvgPicture.asset('assets/icons/map/ic_Pin.svg'),
                      ),
                    ];

                    List<ServiceCenterModel> centers = [];
                    if (state is ServiceCenterSuccess) {
                      centers = state.serviceCenters;
                    }

                    markers.addAll(
                      centers.map(
                        (center) => Marker(
                          point: LatLng(center.latitude, center.longitude),
                          width: 40.w,
                          height: 40.h,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<ServiceCenterCubit>()
                                  .fetchServiceCenterDetails(center.id);
                              context
                                  .read<CurrentLocationCubit>()
                                  .moveToCurrentPosition(
                                    center.latitude,
                                    center.longitude,
                                    mapController: _mapController,
                                  );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/map/blue_pin.svg',
                            ),
                          ),
                        ),
                      ),
                    );

                    return MarkerLayer(markers: markers);
                  },
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              left: 16.w,
              right: 16.w,
              child: CustomSearch(
                hint: S.of(context).mapSearchHint,
                search: search,
                onChanged: (query) {
                  context.read<ServiceCenterCubit>().searchServiceCenters(
                        query,
                      );
                },
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    mini: true,
                    onPressed: () {
                      cubit.zoomIn(mapController: _mapController);
                    },
                    backgroundColor: AppColors.whiteLight,
                    foregroundColor: AppColors.blueNormal,
                    child: const Text('+', style: TextStyle(fontSize: 30, height: 0)),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    mini: true,
                    onPressed: () {
                      cubit.zoomOut(mapController: _mapController);
                    },
                    backgroundColor: AppColors.whiteLight,
                    foregroundColor: AppColors.blueNormal,
                    child: const Text('-', style: TextStyle(fontSize: 35, height: 0)),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: null,
                    mini: true,
                    onPressed: () {
                      final currentPos = cubit.lastKnownPosition;
                      if (currentPos != null) {
                        cubit.moveToCurrentPosition(
                          currentPos.latitude,
                          currentPos.longitude,
                          mapController: _mapController,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).fetchingLocation),
                          ),
                        );
                      }
                    },
                    backgroundColor: AppColors.whiteLight,
                    child: SvgPicture.asset(
                      'assets/icons/map/gps.svg',
                      width: 21.w,
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.25,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteLight,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withAlpha(20),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15.h),
                        width: 48.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: AppColors.blueLightActive,
                          borderRadius: CustomRadius.auth,
                        ),
                      ),
                      Expanded(
                        child:
                            BlocBuilder<ServiceCenterCubit, ServiceCenterState>(
                          builder: (context, state) {
                            if (state is ServiceCenterLoading) {
                              return Skeletonizer(
                                enabled: true,
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ServiceCenterCard(
                                      name: S.of(context).loadingNamePlaceholder,
                                      lat: 0.0,
                                      lng: 0.0,
                                      image: "",
                                      services: const [],
                                      openingTime: "00:00",
                                      closingTime: "00:00",
                                      averageRating: 0.0,
                                      distanceKm: 0.0,
                                      phone: '',
                                      mapController: _mapController,
                                    );
                                  },
                                ),
                              );
                            } else if (state is ServiceCenterFail) {
                              return Center(
                                child: Text(
                                  state.errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else if (state is ServiceCenterSuccess) {
                              final serviceCenters = state.serviceCenters;
                              if (serviceCenters.isEmpty) {
                                return Center(
                                  child: Text(S.of(context).noServiceCentersFound),
                                );
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.only(),
                                controller: scrollController,
                                itemCount: serviceCenters.length > 5
                                    ? 5
                                    : serviceCenters.length,
                                itemBuilder: (context, index) {
                                  final center = serviceCenters[index];
                                  return ServiceCenterCard(
                                    name: center.name,
                                    lat: center.latitude,
                                    lng: center.longitude,
                                    image: center.image,
                                    services: center.services,
                                    openingTime: center.openingTime,
                                    closingTime: center.closingTime,
                                    averageRating: center.averageRating,
                                    distanceKm: center.distanceKm,
                                    phone: center.phone,
                                    mapController: _mapController,
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceCenterDetails(
    BuildContext context,
    ServiceCenterModel center,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.4,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppColors.whiteLight,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          ),
          padding: EdgeInsets.all(16.w),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ServiceCenterCard(
                name: center.name,
                lat: center.latitude,
                lng: center.longitude,
                image: center.image,
                services: center.services,
                openingTime: center.openingTime,
                closingTime: center.closingTime,
                averageRating: center.averageRating,
                distanceKm: center.distanceKm,
                phone: center.phone,
                mapController: _mapController,
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      if (context.mounted) {
        context.read<ServiceCenterCubit>().emitServiceCenters();
      }
    });
  }
}