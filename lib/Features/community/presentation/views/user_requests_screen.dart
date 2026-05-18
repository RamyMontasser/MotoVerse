import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserRequestsScreen extends StatefulWidget {
  const UserRequestsScreen({super.key});

  @override
  State<UserRequestsScreen> createState() => _UserRequestsScreenState();
}

class _UserRequestsScreenState extends State<UserRequestsScreen> {
  bool showAll = false;

  @override
  void initState() {
    super.initState();
    context.read<RequestsCubit>().fetchRequests(mine: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'طلباتي',
                      style: TextStyles.cairoBold24.copyWith(color: AppColors.blueNormal),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showAll = !showAll;
                        });
                      },
                      child: Text(
                        showAll ? 'عرض المعلق فقط' : 'عرض الكل',
                        style: TextStyles.cairoBold14.copyWith(color: AppColors.blueNormal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BlocBuilder<RequestsCubit, RequestsState>(
              builder: (context, state) {
                if (state is RequestsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Card(
                        child: ListTile(
                          title: Text('Loading...'),
                          subtitle: Text('Loading...'),
                        ),
                      ),
                    ),
                  );
                } else if (state is RequestsFail) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is RequestsSuccess) {
                  final requests = showAll 
                    ? state.requests 
                    : state.requests.where((request) => request.status == 'pending').toList();
                  if (requests.isEmpty) {
                    return const Center(
                      child: Text('لا توجد طلبات سابقة'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return RequestCard(
                        request: request,
                        isChat: request.requestType == 'online',
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
                  },
                ),
              ],
              ),
            ),
          ),
      );
  }
}
