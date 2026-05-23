import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/presentation/cubit/review_cubit.dart';
import 'package:motoverse/Features/community/presentation/views/review_screen_body.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final offerId = (args?['offerId'] as dynamic)?.toInt() ?? 0;
    final helperName = (args?['helperName'] ?? '') as String;
    final helperAvatar = args?['helperAvatar']?.toString();
    final otherUserId = (args?['otherUserId'] ?? '').toString();
    final averageRating = (args?['averageRating'] ?? '').toString();
    return BlocProvider(
      create: (context) => ReviewCubit(communityRepo: getIt<CommunityRepo>()),
      child: Scaffold(
        body: ReviewScreenBody(
          offerId: offerId,
          helperName: helperName,
          helperAvatar: helperAvatar,
          otherUserId: otherUserId,
          averageRating: averageRating,
        ),
      ),
    );
  }
}
