import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/map/domain/repo/service_center_repo.dart';
import 'package:motoverse/Features/map/presentation/bodies/map_body.dart';
import 'package:motoverse/Features/map/presentation/cubit/service_center_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) =>
      //     ServiceCenterCubit(serviceCenterRepo: getIt<ServiceCenterRepo>()),
      create: (context) {
        final serviceCenterCubit = ServiceCenterCubit(
          serviceCenterRepo: getIt<ServiceCenterRepo>(),
        );
        final locationState = context.read<CurrentLocationCubit>().state;
        if (locationState is CurrentLocationSuccess) {
          serviceCenterCubit.fetchServiceCenters(
            lat: locationState.currentLocation.latitude,
            long: locationState.currentLocation.longitude,
          );
        }
        return serviceCenterCubit;
      },
      child: BlocConsumer<CurrentLocationCubit, CurrentLocationState>(
        listener: (context, state) {
          if (state is CurrentLocationFailure) {
            customSnackBar(context: context, msg: state.errMsg, isDone: false);
          }
          if (state is CurrentLocationSuccess) {
            context.read<ServiceCenterCubit>().fetchServiceCenters(
              lat: state.currentLocation.latitude,
              long: state.currentLocation.longitude,
            );
          }
        },
        builder: (context, state) {
          if (state is CurrentLocationLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.yellowNormal),
              ),
            );
          }

          // Position? currentPos;
          // if (state is CurrentLocationSuccess) {
          //   currentPos = state.currentLocation;
          // }

          final currentPos = context
              .read<CurrentLocationCubit>()
              .lastKnownPosition;

          return CustomScrollViewWithAppBar(
            child: MapBody(currentPosition: currentPos),
          );

          // Position? currentPosiotion;
          // if (state is CurrentLocationSuccess) {
          //   currentPosiotion = state.currentLocation;
          //   debugPrint('$currentPosiotion');
          //   // context.read<CurrentLocationCubit>().moveToCurrentPosition(
          //   //   state.currentLocation.latitude,
          //   //   state.currentLocation.longitude,
          //   // );
          // }
          // return ModalProgressHUD(
          //   inAsyncCall: state is CurrentLocationLoading,
          //   child: CustomScrollViewWithAppBar(
          //     child: MapBady(currentPosition: currentPosiotion),
          //   ),
          // );
        },
      ),
    );
  }
}
