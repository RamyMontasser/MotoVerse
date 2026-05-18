import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final String? receiverAvatar;

  const MessageBubble({super.key, required this.message, this.receiverAvatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe )
                Padding(
                  padding: EdgeInsets.only(right: 3.w, left: 7.w, top: 15.h),
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundImage: receiverAvatar != null && receiverAvatar!.isNotEmpty
                        ? NetworkImage(
                            receiverAvatar!.startsWith('http')
                                ? receiverAvatar!
                                : "${AppConstants.baseUrl}/${receiverAvatar!}",
                          )
                        : null,
                    child: receiverAvatar == null || receiverAvatar!.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ),
              // SizedBox(width: 5.w,),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? AppColors.blueNormal
                        : AppColors.blueGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: message.isMe
                          ? Radius.circular(isEN() ? 16.r : 0)
                          : Radius.circular(isEN() ? 0 : 16.r),
                      bottomRight: message.isMe
                          ? Radius.circular(isEN() ? 0 : 16.r)
                          : Radius.circular(isEN() ? 16.r : 0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.imageUrl != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              message.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Text(
                        message.text,
                        style: TextStyles.cairoRegular16.copyWith(
                          color: message.isMe ? AppColors.whiteLight : AppColors.black,
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: message.isMe
                            ? isEN() 
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start
                            :isEN() 
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          // if (message.isMe)
                          //   SizedBox(width: 20.w,),
                          Text(
                            DateFormat(
                              'hh:mm a',
                            ).format(message.timestamp.toDate()),
                            style: TextStyles.cairoBold13.copyWith(
                              color: message.isMe ? AppColors.whiteDark : AppColors.whiteDarker,
                              // fontSize: 10.sp,
                            ),
                          ),
                          if (message.isMe) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.done_all,
                              size: 14.sp,
                              color: message.isSeen ? Colors.blue : Colors.grey,
                            ),
                          ],
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 4.h),/
          
        ],
      ),
    );
  }
}

bool isEN() {
  return Intl.getCurrentLocale() == 'en';
}
