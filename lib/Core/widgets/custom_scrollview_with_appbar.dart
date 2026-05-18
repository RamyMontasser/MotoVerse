import 'package:flutter/material.dart';
import 'package:motoverse/Core/widgets/custom_sliver_appbar.dart';

class CustomScrollViewWithAppBar extends StatelessWidget {
  const CustomScrollViewWithAppBar({super.key, required this.child, this.controller});

  final Widget child;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          CustomSliverAppbar(),
      
          SliverToBoxAdapter(child: child),
        ],
      ),
    );
  }
}
