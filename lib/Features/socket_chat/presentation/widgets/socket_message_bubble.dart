import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Features/socket_chat/data/models/text_message_model.dart';

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
                    top: 15.h,
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                                      : "${AppConstants.baseUrl}${message.imageUrl!}",
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
                              child: _AudioPlayMockupWidget(
                                isMe: message.isMe,
                                audioUrl: message.audioUrl,
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
                          ? isEN()
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start
                          : isEN()
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
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

/// A Premium State-of-the-art Custom Audio Bubble Player Mockup Widget.
class _AudioPlayMockupWidget extends StatefulWidget {
  final bool isMe;
  final String? audioUrl;

  const _AudioPlayMockupWidget({required this.isMe, this.audioUrl});

  @override
  State<_AudioPlayMockupWidget> createState() => _AudioPlayMockupWidgetState();
}

class _AudioPlayMockupWidgetState extends State<_AudioPlayMockupWidget>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _playbackProgress = 0.3;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _playbackProgress = 0.7;
      } else {
        _playbackProgress = 0.3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeColor = widget.isMe
    //     ? AppColors.whiteLight
    //     : AppColors.blueNormal;
    final waveColor = widget.isMe
        ? AppColors.whiteDark.withValues(alpha: 0.5)
        : AppColors.whiteDarker.withValues(alpha: 0.3);
    final waveActiveColor = widget.isMe
        ? AppColors.yellowNormal
        : AppColors.blueNormal;

    return Container(
      width: 240.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: widget.isMe
            ? AppColors.blueDark.withValues(alpha: 0.15)
            : AppColors.blueLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.isMe
              ? AppColors.whiteLight.withValues(alpha: 0.1)
              : AppColors.blueLightActive.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Elegant Glassmorphic Play/Pause Button
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              height: 36.w,
              width: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isMe
                    ? AppColors.whiteLight
                    : AppColors.blueNormal,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: widget.isMe
                    ? AppColors.blueNormal
                    : AppColors.whiteLight,
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Audio Waveform Visualization
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(24, (index) {
                      // Generate simulated bar heights
                      final heights = [
                        4,
                        8,
                        15,
                        12,
                        6,
                        18,
                        22,
                        10,
                        5,
                        9,
                        14,
                        20,
                        16,
                        7,
                        11,
                        24,
                        13,
                        8,
                        4,
                        10,
                        15,
                        7,
                        12,
                        6,
                      ];
                      final isPassed = index / 24.0 <= _playbackProgress;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 2.5.w,
                        height:
                            heights[index % heights.length].h *
                            (_isPlaying && index % 3 == 0
                                ? _pulseController.value * 0.4 + 0.8
                                : 0.85),
                        decoration: BoxDecoration(
                          color: isPassed ? waveActiveColor : waveColor,
                          borderRadius: BorderRadius.circular(1.r),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isPlaying ? "0:14" : "0:00",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: widget.isMe
                            ? AppColors.whiteDark
                            : AppColors.whiteDarker,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "0:42",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: widget.isMe
                            ? AppColors.whiteDark
                            : AppColors.whiteDarker,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
