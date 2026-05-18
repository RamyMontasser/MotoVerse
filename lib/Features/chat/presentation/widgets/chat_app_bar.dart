import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_app_dialog.dart';
// import 'package:motoverse/Core/widgets/custom_dialog.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String status;
  final String? avatarUrl;
  final Function onDeleteChat;
  final bool isHelper;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.status,
    required this.avatarUrl, required this.onDeleteChat, required this.isHelper,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueNormal,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.yellowNormal),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
                  radius: 20.r,
                  backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? NetworkImage(
                    avatarUrl!.startsWith('http')
                        ? avatarUrl!
                        : "${AppConstants.baseUrl}/${avatarUrl!}",
                  )
                : null,
                child: avatarUrl == null || avatarUrl!.isEmpty
                    ? const Icon(Icons.person)
                    : null,
                ),
              // : CircleAvatar(
              //     radius: 20.r,
              //     child: Icon(Icons.person, color: AppColors.blueNormal),
              //   ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.cairoBold16.copyWith(color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    '$status • ',
                    style: TextStyles.cairoMedium12.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Icon(
                    Icons.verified,
                    color: AppColors.yellowNormal,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'منقذ معتمد',
                    style: TextStyles.cairoBold12.copyWith(
                      color: AppColors.yellowNormal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: AppColors.whiteLight),
          shape: RoundedRectangleBorder(borderRadius: CustomRadius.auth),
          padding: EdgeInsets.zero,
          color: AppColors.whiteLight,
          itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () => showDialog(
                context: context, 
                builder: (context) => CustomAppDialog(
                title: 'انهاء المحادثة',
                desc: isHelper? 'سيتم حذف عرض المساعدة الخاص بك':'سيتم حذف المحادثة بمجرد انهائها',
                btnText: isHelper? 'حذف عرض المساعدة': 'حذف المحادثة',
                onTap: (){
                  onDeleteChat();
                  Navigator.pop(context);
                  CustomAppDialog(
                    title: 'تم حذف المحادثة بنجاح',
                    desc: 'هل تم حل مشكلتك؟',
                    btnText: 'نعم ',
                    btnText2: 'لا',
                    onTap: (){
                      Navigator.pushNamedAndRemoveUntil(
                            context,
                            'main screen',
                            (route) => false,
                          );
                    }, onTap2: (){
                      Navigator.pushNamedAndRemoveUntil(
                            context,
                            'main screen',
                            (route) => false,
                          );
                    },
                  );
                },
              )),
              child: Text('Delete Chat', style: TextStyles.cairoBold16.copyWith(color: AppColors.redNormal),)),
          ];
        } ), 
        // IconButton(
        //   icon: const Icon(Icons.more_vert, color: Colors.white),
        //   onPressed: () {
        //   },
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10.h);
}
