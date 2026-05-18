import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/community/data/models/request_location_model.dart';
import 'package:motoverse/Features/community/data/models/request_model.dart';
import 'package:motoverse/Features/community/domain/repo/community_repo.dart';
import 'package:motoverse/Features/community/presentation/cubit/requests_cubit.dart';
import 'package:motoverse/Features/community/presentation/widgets/category_tabs.dart';
import 'package:motoverse/Features/community/presentation/widgets/request_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AvailableRequests extends StatefulWidget {
  const AvailableRequests({super.key});

  @override
  State<AvailableRequests> createState() => _AvailableRequestsState();
}

class _AvailableRequestsState extends State<AvailableRequests> {
  int currentCategory = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestsCubit(communityRepo: getIt<CommunityRepo>())..fetchRequests(),
      child: Scaffold(
        body: CustomScrollViewWithAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                CategoryTabs(
                  selectedIndex: currentCategory,
                  onTap: (int index) {
                    setState(() {
                      currentCategory = index;
                    });
                  },
                ),
                BlocBuilder<RequestsCubit, RequestsState>(
                  builder: (context, state) {
                    if (state is RequestsLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            if (currentCategory == 1) {
                              return RequestCard(
                                isChat: true,
                                request: RequestModel(
                                  id: 1,
                                  userId: 1,
                                  userName: 'John Doe',
                                  userImage: '',
                                  memberSince: 2022,
                                  city: 'New York',
                                  description: 'I need help with my motorcycle',
                                  problemType: 'Mechanical',
                                  requestType: 'online',
                                  images: [],
                                  imagesCount: 0,
                                  status: 'open',
                                  createdAt: '2022-01-01 00:00:00',
                                ),
                              );
                            } else if (currentCategory == 2) {
                              return RequestCard(
                                isChat: false,
                                request: RequestModel(
                                  id: 1,
                                  userId: 1,
                                  userName: 'John Doe',
                                  userImage: '',
                                  memberSince: 2022,
                                  city: 'New York',
                                  location: RequestLocationModel(
                                    latitude: 40.7128,
                                    longitude: -74.0060,
                                  ),
                                  description: 'I need help with my motorcycle',
                                  problemType: 'Mechanical',
                                  requestType: 'online',
                                  images: [],
                                  imagesCount: 0,
                                  status: 'open',
                                  createdAt: '2022-01-01 00:00:00',
                                ),
                              );
                            } else if (index % 2 == 0) {
                              return RequestCard(
                                isChat: true,
                                request: RequestModel(
                                  id: 1,
                                  userId: 1,
                                  userName: 'John Doe',
                                  userImage: '',
                                  memberSince: 2022,
                                  city: 'New York',
                                  location: RequestLocationModel(
                                    latitude: 40.7128,
                                    longitude: -74.0060,
                                  ),
                                  description: 'I need help with my motorcycle',
                                  problemType: 'Mechanical',
                                  requestType: 'online',
                                  images: [],
                                  imagesCount: 0,
                                  status: 'open',
                                  createdAt: '2022-01-01 00:00:00',
                                ),
                              );
                            }
                            return RequestCard(
                              isChat: false,
                              request: RequestModel(
                                id: 1,
                                userId: 1,    
                                userName: 'John Doe',
                                userImage: '',
                                memberSince: 2022,
                                city: 'New York',
                                location: RequestLocationModel(
                                  latitude: 40.7128,
                                  longitude: -74.0060,
                                ),
                                description: 'I need help with my motorcycle',
                                problemType: 'Mechanical',
                                requestType: 'online',
                                images: [],
                                imagesCount: 0,
                                status: 'open',
                                createdAt: '2022-01-01 00:00:00',
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is RequestsFail) {
                      debugPrint(state.errorMessage);
                      return Center(
                        child: Text(
                          'حدث خطأ اثناء تحميل الطلبات',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is RequestsSuccess) {
                      final requests = state.requests
                          .where((request) => request.status == 'pending')
                          .toList();
                      if (requests.isEmpty) {
                        return const Center(child: Text("لا توجد طلبات متاحة"));
                      }
                      final filteredRequests = requests.where((request) {
                        if (currentCategory == 1) {
                          return request.requestType == 'online';
                        }
                        if (currentCategory == 2) {
                          return request.requestType == 'offline';
                        }
                        return true;
                      }).toList();
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredRequests.length,
                        itemBuilder: (context, index) {
                          final request = filteredRequests[index];
                          // bool isChat;
                          // if (currentCategory == 1 &&
                          //     request.requestType == 'online') {
                          //   isChat = true;
                          // } else if (currentCategory == 2 &&
                          //     request.requestType == 'offline') {
                          //   isChat = false;
                          // } else {
                          //   isChat = (request.requestType == 'online');
                          // }

                          return RequestCard(
                            isChat: request.requestType == 'online',
                            request: request,
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
      ),
    );
  }
}
