import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_elevatedbutton.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Core/widgets/custom_search.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/old_chats.dart';

class AiChat1 extends StatefulWidget {
  const AiChat1({super.key});

  @override
  State<AiChat1> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat1> {
  TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollViewWithAppBar(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            CustomSearch(hint: 'ابحث عن محادثة قديمة....', search: search),
            SizedBox(height: 25.h),

            OldChats(
              title: 'مشكلة في الفرامل',
              iconPath: 'assets/icons/chats/ropot.svg',
              date: 'September 28, 2023',
              time: '04:45 PM',
              fun: () {},
            ),
            SizedBox(height: 10.h),
            OldChats(
              title: 'ضعف تبريد التكيف',
              iconPath: 'assets/icons/chats/snow.svg',
              date: 'September 28, 2023',
              time: '04:45 PM',
              fun: () {},
            ),

            SizedBox(height: 50.h),

            CustomElevatedButton(
              text: 'محادثة جديدة',
              radius: CustomRadius.card12,
              fun: (){Navigator.of(context).pushNamed('ai2');},
              height: 50.h,
              withBorder: false,
              fontStyle: TextStyles.cairoBold16,
              prefixIcon: Icon(Icons.add_box_outlined, size: 20.sp,),
            ),
            
          ],
        ),
      ),
    );
  }
}
