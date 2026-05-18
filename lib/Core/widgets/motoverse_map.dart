// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';

// class MotoVerseMap extends StatelessWidget {
//   final double initialZoom;
//   final List<Marker> additionalMarkers;
//   final bool isInteractive;
//   final bool showUserMarker;

//   const MotoVerseMap({
//     super.key,
//     this.initialZoom = 15.0,
//     this.additionalMarkers = const [],
//     this.isInteractive = true,
//     this.showUserMarker = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CurrentLocationCubit, CurrentLocationState>(
//       listener: (context, state) {
//         if (state is CurrentLocationSuccess) {
//           context.read<CurrentLocationCubit>().moveToCurrentPosition(
//             state.currentLocation.latitude,
//             state.currentLocation.longitude,
//           );
//         }
//       },
//       builder: (context, state) {
//         final cubit = context.read<CurrentLocationCubit>();
//         final userPos = cubit.lastKnownPosition;

//         return FlutterMap(
//           mapController: cubit.mapController,
//           options: MapOptions(
//             initialCenter: userPos != null
//                 ? LatLng(userPos.latitude, userPos.longitude)
//                 : const LatLng(
//                     31.41285350123302,
//                     31.81483832912789,
//                   ), 
//             initialZoom: initialZoom,
//             interactionOptions: InteractionOptions(
//               flags: isInteractive ? InteractiveFlag.all : InteractiveFlag.none,
//             ),
//           ),
//           children: [
//             TileLayer(
//               urlTemplate:
//                   ,
//               additionalOptions: {
//                 'accessToken':
//                     ,
//                 'id':,
//               },
//               subdomains: ['a', 'b', 'c', 'd'],
//               userAgentPackageName: 'com.example.motoverse',
//             ),

//             MarkerLayer(
//               markers: [
//                 if (showUserMarker && userPos != null)
//                   Marker(
//                     point: LatLng(
//                             userPos.latitude,
//                             userPos.longitude,
//                           ),
//                     width: 50,
//                     height: 50,
//                     child: SvgPicture.asset('assets/icons/map/ic_Pin.svg'),
//                     //  Icon(
//                     //   Icons.location_on,
//                     //   color: AppColors.yellowNormal,
//                     //   size: 40,
//                     // ),
//                   ),

//                 ...additionalMarkers,
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
