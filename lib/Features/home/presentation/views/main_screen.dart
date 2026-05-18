import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/providers/navigation_provider.dart';
import 'package:motoverse/Core/widgets/custom_navigationbar.dart';
import 'package:motoverse/Features/ai_chat/presentation/views/ai_chat1.dart';
import 'package:motoverse/Features/community/presentation/views/community.dart';
import 'package:motoverse/Features/home/presentation/cubit/current_location_cubit.dart';
import 'package:motoverse/Features/home/presentation/cubit/user_cubit_cubit.dart';
import 'package:motoverse/Features/home/presentation/views/home.dart';
import 'package:motoverse/Features/map/presentation/views/map.dart';
import 'package:motoverse/Features/home/presentation/views/profile.dart';
import 'package:provider/provider.dart';


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
      const AiChat1(),
      const CommunityMain(),
      const MapPage(),
      const Profile(),
    ];
    
    context.read<CurrentLocationCubit>().getCurrentLocation();
    context.read<UserCubitCubit>().getUserToken();
  }



  @override
  Widget build(BuildContext context) {
    debugPrint('uid: ${FirebaseAuth.instance.currentUser?.uid}');
    final navProvider = context.watch<NavigationProvider>();
    return BlocListener<CurrentLocationCubit, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationSuccess) {
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
        ),
      ),
    );
  }
}

