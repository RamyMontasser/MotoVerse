import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/functions/custom_snackbar.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/home/data/models/offer_model.dart';
import 'package:motoverse/Features/home/presentation/cubit/my_offers_cubit.dart';
import 'package:motoverse/Features/home/presentation/widgets/my_offer_page_card.dart';
import 'package:motoverse/Features/home/presentation/widgets/my_offers_category_tabs.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyOffersPage extends StatefulWidget {
  const MyOffersPage({super.key, this.initialCategory = 0});

  final int initialCategory;

  @override
  State<MyOffersPage> createState() => _MyOffersPageState();
}

class _MyOffersPageState extends State<MyOffersPage> {
  late int currentCategory;
  List<OfferModel> myOffers = [];

  @override
  void initState() {
    super.initState();
    currentCategory = widget.initialCategory;
    context.read<MyOffersCubit>().getMyOffers();
  }

  String getEmptyMessage() {
    switch (currentCategory) {
      case 1:
        return 'لا توجد عروض مقبولة حالياً';
      case 2:
        return 'لا توجد عروض قيد الانتظار حالياً';

      case 3:
        return 'لا توجد عروض مكتملة حالياً';
      case 4:
        return 'لا توجد عروض مرفوضة حالياً';

      default:
        return 'لا توجد عروض مقدمة حالياً';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWithAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عروضي',
                style: TextStyles.cairoBold24.copyWith(
                  color: AppColors.blueNormal,
                ),
              ),
              SizedBox(height: 20.h),
              MyOffersCategoryTabs(
                selectedIndex: currentCategory,
                onTap: (int index) {
                  setState(() {
                    currentCategory = index;
                  });
                },
              ),
              SizedBox(height: 20.h),
              BlocListener<MyOffersCubit, MyOffersState>(
                listener: (context, state) {
                  if (state is DeleteOfferSuccess) {
                    customSnackBar(
                      context: context,
                      msg: 'تم حذف العرض بنجاح',
                      isDone: true,
                    );
                    context.read<MyOffersCubit>().getMyOffers();
                  } else if (state is DeleteOfferFailure) {
                    customSnackBar(
                      context: context,
                      msg: state.errMessage,
                      isDone: false,
                    );
                    context.read<MyOffersCubit>().getMyOffers();
                  } else if (state is RequestDetailsLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blueNormal,
                        ),
                      ),
                    );
                  } else if (state is RequestDetailsSuccess) {
                    Navigator.pop(context);
                    final currentOffer = myOffers.firstWhere(
                      (offer) => offer.request == state.request.id,
                    );

                    final List<dynamic> args = [
                      state.request,
                      currentOffer,
                      true,
                    ];

                    Navigator.pushNamed(
                      context,
                      'HelpOffline',
                      arguments: args,
                    );
                    // Navigator.pushNamed(
                    //   context,
                    //   'chat',
                    //   arguments: {
                    //     'otherUserId': state.request.userId,
                    //     'otherUserName': state.request.userName,
                    //     'otherUserAvatar': null,
                    //     'isHelper': true,
                    //   },
                    // );
                  } else if (state is RequestDetailsFailure) {
                    Navigator.pop(context);
                    customSnackBar(
                      context: context,
                      msg: state.errMessage,
                      isDone: false,
                    );
                  }
                },
                child: BlocBuilder<MyOffersCubit, MyOffersState>(
                  buildWhen: (previous, current) =>
                      current is MyOffersLoading ||
                      current is MyOffersSuccess ||
                      current is MyOffersFailure,
                  builder: (context, state) {
                    if (state is MyOffersLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) => const Card(
                            child: ListTile(
                              title: Text('Loading...'),
                              subtitle: Text('Loading...'),
                            ),
                          ),
                        ),
                      );
                    } else if (state is MyOffersFailure) {
                      return Center(
                        child: Text(
                          state.errMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is MyOffersSuccess) {
                      myOffers = state.offers;
                    }

                    final filteredOffers = myOffers.where((offer) {
                      if (currentCategory == 1)
                        return offer.status == 'accepted';
                      if (currentCategory == 2)
                        return offer.status == 'pending';
                      if (currentCategory == 3)
                        return offer.status == 'completed';
                      if (currentCategory == 4)
                        return offer.status == 'rejected';
                      return true;
                    }).toList();

                    if (filteredOffers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 100.h),
                            Icon(
                              Icons.local_offer_outlined,
                              size: 80.sp,
                              color: AppColors.blueGrey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              getEmptyMessage(),
                              style: TextStyles.cairoBold16.copyWith(
                                color: AppColors.whiteDarkActive,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredOffers.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return MyOfferPageCard(
                          offerModel: filteredOffers[index],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
