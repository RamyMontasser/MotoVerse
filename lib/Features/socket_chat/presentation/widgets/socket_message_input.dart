import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/custom_radius.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/image_picker_bottom_sheet.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_cubit.dart';

class SocketMessageInput extends StatefulWidget {
  final String chatId;

  const SocketMessageInput({super.key, required this.chatId});

  @override
  State<SocketMessageInput> createState() => _SocketMessageInputState();
}

class _SocketMessageInputState extends State<SocketMessageInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  bool _isRecording = false;
  String? _recordingPath;
  Timer? _timer;
  int _recordDuration = 0; // in seconds
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _timer?.cancel();
    _audioRecorder.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // --- Image Picking Logic ---
  void _pickImage() {
    ImagePickerBottomSheet.show(
      context: context,
      onImagePicked: (xFile) {
        if (xFile != null) {
          context.read<SocketChatCubit>().sendMediaMessage(
                chatId: widget.chatId,
                filePath: xFile.path,
                fileType: 'image',
              );
        }
      },
    );
  }

  // --- Voice Note Recording Logic ---
  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final tempDir = await getTemporaryDirectory();
        final path =
            '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
        _recordingPath = path;

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        setState(() {
          _isRecording = true;
          _recordDuration = 0;
        });

        _timer = Timer.periodic(const Duration(seconds: 1), (t) {
          setState(() {
            _recordDuration++;
          });
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('يرجى تمكين إذن الميكروفون للتسجيل'),
              backgroundColor: AppColors.redNormal,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Error starting record: $e");
    }
  }

  Future<void> _stopAndSendRecording() async {
    try {
      _timer?.cancel();
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
      });

      if (path != null) {
        if (mounted) {
          context.read<SocketChatCubit>().sendMediaMessage(
                chatId: widget.chatId,
                filePath: path,
                fileType: 'audio',
              );
        }
      }
    } catch (e) {
      debugPrint("Error stopping record: $e");
    }
  }

  Future<void> _cancelRecording() async {
    try {
      _timer?.cancel();
      await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
      });

      if (_recordingPath != null) {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (e) {
      debugPrint("Error cancelling record: $e");
    }
  }

  void _sendMessage() {
    final String messageText = _controller.text.trim();
    if (messageText.isEmpty) return;

    context.read<SocketChatCubit>().sendMessage(
          chatId: widget.chatId,
          message: messageText,
        );
    _controller.clear();
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteLight,
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        top: 10.h,
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 10.h : 25.h,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _isRecording ? _buildRecordingBar() : _buildNormalBar(),
      ),
    );
  }

  Widget _buildNormalBar() {
    final isTextEmpty = _controller.text.trim().isEmpty;

    return Row(
      key: const ValueKey('normal_bar'),
      children: [
        // Attachment Plus Button
        IconButton(
          onPressed: _pickImage,
          icon: Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.yellowNormal,
            size: 28.sp,
          ),
          tooltip: 'إرفاق صورة',
        ),
        
        // Message Input Field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteNormal,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: Colors.black12),
            ),
            child: TextFormField(
              controller: _controller,
              cursorColor: AppColors.yellowNormal,
              style: TextStyles.cairoRegular16.copyWith(
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                hintStyle: TextStyles.cairoRegular14.copyWith(
                  color: AppColors.whiteDark,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),

        // Action Button: Send or Microphone
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          style: IconButton.styleFrom(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: CustomRadius.circle,
            ),
            backgroundColor: AppColors.yellowNormal,
          ),
          onPressed: isTextEmpty ? _startRecording : _sendMessage,
          icon: Icon(
            isTextEmpty ? Icons.mic_none_rounded : Icons.send_rounded,
            color: AppColors.whiteLight,
            size: 22.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordingBar() {
    return Row(
      key: const ValueKey('recording_bar'),
      children: [
        // Cancel/Delete Button (Red trash can)
        IconButton(
          onPressed: _cancelRecording,
          icon: Icon(
            Icons.delete_outline_rounded,
            color: AppColors.redNormal,
            size: 28.sp,
          ),
          tooltip: 'إلغاء التسجيل',
        ),

        // Record Status & Elapsed Timer
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.redNormal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: AppColors.redNormal.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                // Flashing Red Dot Animation
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _pulseController.value,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: AppColors.redNormal,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 8.w),

                // Arab State text
                Text(
                  'تسجيل صوتي...',
                  style: TextStyles.cairoBold13.copyWith(
                    color: AppColors.redNormal,
                  ),
                ),
                const Spacer(),

                // Duration timer text
                Text(
                  _formatDuration(_recordDuration),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),

        // Send Audio Button
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          style: IconButton.styleFrom(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: CustomRadius.circle,
            ),
            backgroundColor: AppColors.blueNormal,
          ),
          onPressed: _stopAndSendRecording,
          icon: Icon(
            Icons.check_rounded,
            color: AppColors.whiteLight,
            size: 22.sp,
          ),
          tooltip: 'إرسال التسجيل',
        ),
      ],
    );
  }
}
