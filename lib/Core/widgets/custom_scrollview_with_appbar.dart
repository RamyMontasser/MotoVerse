import 'package:flutter/material.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/widgets/custom_sliver_appbar.dart';

class CustomScrollViewWithAppBar extends StatelessWidget {
  const CustomScrollViewWithAppBar({
    super.key,
    required this.child,
    this.controller,
    this.physics,
    this.onRefresh,
  });

  final Widget child;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final scrollView = SafeArea(
      bottom: false,
      child: CustomScrollView(
        controller: controller,
        physics: onRefresh != null
            ? (physics ?? const AlwaysScrollableScrollPhysics())
            : physics,
        slivers: [
          const CustomSliverAppbar(),

          SliverToBoxAdapter(child: child),
        ],
      ),
    );

    if (onRefresh == null) {
      return scrollView;
    }

    return RefreshIndicator(
      backgroundColor: AppColors.whiteLight,
      color: AppColors.yellowNormal,
      onRefresh: onRefresh!,
      child: scrollView,
    );
  }
}
