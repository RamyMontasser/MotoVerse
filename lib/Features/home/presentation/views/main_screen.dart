// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/widgets/custom_navigationbar.dart';
import 'package:motoverse/Features/bot/presentation/views/ai_options_screen.dart';
// import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/community/presentation/views/community.dart';
// import 'package:motoverse/Features/history/presentation/cubit/history_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
// import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/views/home.dart';
import 'package:motoverse/Features/map/presentation/views/map.dart';
import 'package:motoverse/Features/profile/presentation/views/profile_screen.dart';
// import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const Home(),

      // const AiChat1(),
      const AiOptionsScreen(),
      const CommunityMain(),
      const MapPage(),
      const ProfileScreen(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CurrentLocationCubit>().getCurrentLocation();
      // context.read<UserCubitCubit>().getUserToken();
    });
  }

  // Future<void> _refreshAll() async {
  //   await Future.wait([
  //     context.read<CurrentLocationCubit>().getCurrentLocation(
  //       forceRefresh: true,
  //     ),
  //     context.read<UserCubitCubit>().getUserInfo(),
  //     context.read<RequestsCubit>().fetchRequests(mine: true),
  //     context.read<MyOffersCubit>().getMyOffers(),
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    return BlocListener<CurrentLocationCubit, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationSuccess) {
          context.read<UserCubitCubit>().getUserInfo();
        }
        if (state is CurrentLocationFailure) {
          context.read<UserCubitCubit>().getUserInfo();
        }
      },
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CustomNavigationBar(
            selectedIndex: navProvider.selectedIndex,
            onItemTapped: (index) {
              navProvider.changeIndex(index);
            },
          ),
          body: IndexedStack(index: navProvider.selectedIndex, children: pages),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _refreshAll,
          //   backgroundColor: Colors.blue,
          //   child: const Icon(Icons.refresh),
          // ),
        ),
      ),
    );
  }
}
