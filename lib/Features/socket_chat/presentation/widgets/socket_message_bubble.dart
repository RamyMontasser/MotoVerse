import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/socket_chat/data/models/text_message_model.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/audio_player_widget.dart';

class SocketMessageBubble extends StatelessWidget {
  final TextMessageModel message;
  final String? receiverAvatar;

  const SocketMessageBubble({
    super.key,
    required this.message,
    this.receiverAvatar,
  });

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
              if (!message.isMe)
                Padding(
                  padding: EdgeInsets.only(
                    right: isEN() ? 4.w : 0,
                    left: isEN() ? 0 : 4.w,
                    // bottom: 15.h,
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.blueLight,
                    radius: 20.r,
                    backgroundImage:
                        receiverAvatar != null && receiverAvatar!.isNotEmpty
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
              Flexible(
                child: Column(
                  crossAxisAlignment: message.isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: message.isMe
                            ? AppColors.blueNormal
                            : AppColors.blueGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: message.isMe
                              ? Radius.circular(16.r)
                              : Radius.circular(isEN() ? 0 : 16.r),
                          topRight: message.isMe
                              ? Radius.circular(16.r)
                              : Radius.circular(isEN() ? 16.r : 0),
                          bottomLeft: message.isMe
                              ? Radius.circular(isEN() ? 16.r : 0)
                              : Radius.circular(16.r),
                          bottomRight: message.isMe
                              ? Radius.circular(isEN() ? 0 : 16.r)
                              : Radius.circular(16.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Render Image Message if available
                          if (message.type == 'image' &&
                              message.imageUrl != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  message.imageUrl!.startsWith('http')
                                      ? message.imageUrl!
                                      : "${AppConstants.baseUrl}/media/${message.imageUrl!}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        height: 150.h,
                                        width: 200.w,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ),

                          // Render Audio Message if available
                          if (message.type == 'audio')
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: AudioPlayerWidget(
                                audioUrl: message.audioUrl,
                                isMe: message.isMe,
                              ),
                            ),

                          // Render Text Message
                          if (message.message.isNotEmpty)
                            Text(
                              message.message,
                              style: TextStyles.cairoRegular16.copyWith(
                                color: message.isMe
                                    ? AppColors.whiteLight
                                    : AppColors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: message.isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      // message.isMe
                      //     ? isEN()
                      //           ? MainAxisAlignment.end
                      //           : MainAxisAlignment.start
                      //     : isEN()
                      //     ? MainAxisAlignment.start
                      //     : MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('hh:mm a').format(message.timestamp),
                          style: TextStyles.cairoRegular11.copyWith(
                            color: message.isMe
                                ? AppColors.whiteDark
                                : AppColors.whiteDarker,
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
            ],
          ),
        ],
      ),
    );
  }

  bool isEN() {
    return Intl.getCurrentLocale() == 'en';
  }
}
