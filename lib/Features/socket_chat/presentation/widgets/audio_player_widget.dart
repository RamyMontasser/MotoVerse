import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

/// A reusable audio player widget that displays audio with play controls and waveform visualization.
/// Can be used standalone or within message bubbles.
class AudioPlayerWidget extends StatefulWidget {
  final String? audioUrl;
  final bool isMe;
  final double? width;
  final Function()? onStateChanged;

  const AudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.isMe,
    this.width,
    this.onStateChanged,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = false;
  String? _errorMessage;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
        widget.onStateChanged?.call();
      }
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) setState(() => _duration = d);
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) setState(() => _position = p);
    });

    // عشان تصفر العداد لما الفويس يخلص
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _position = Duration.zero;
          _isPlaying = false;
        });
        widget.onStateChanged?.call();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    try {
      if (widget.audioUrl == null || widget.audioUrl!.isEmpty) {
        _setError('Invalid audio URL');
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final url = widget.audioUrl!.startsWith('http')
          ? widget.audioUrl!
          : "${AppConstants.baseUrl}${widget.audioUrl!}";

      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        // 1. لو الفويس خلص ووصل للآخر أو العداد تم تصفيره، بنشغله من جديد تماماً عبر play
        if (_position == Duration.zero || _position >= _duration) {
          await _audioPlayer.play(UrlSource(url));
        }
        // 2. لو الفويس واخد Pause في النص، خليه يكمل عادي من مكانه بـ resume
        else {
          await _audioPlayer.resume();
        }
      }
    } catch (e) {
      _setError('Error: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _setError(String message) {
    if (mounted) {
      setState(() {
        _errorMessage = message;
        _isPlaying = false;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final waveColor = widget.isMe
        ? AppColors.whiteDark.withValues(alpha: 0.5)
        : AppColors.whiteDarker.withValues(alpha: 0.3);
    final waveActiveColor = widget.isMe
        ? AppColors.yellowNormal
        : AppColors.blueNormal;

    final playbackProgress = _duration.inMilliseconds > 0
        ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_errorMessage != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              _errorMessage!,
              style: TextStyle(fontSize: 10.sp, color: AppColors.redNormal),
            ),
          ),
        Container(
          width: widget.width ?? 240.w,
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
              // Play/Pause Button
              GestureDetector(
                onTap: _isLoading ? null : _togglePlay,
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
                  child: _isLoading
                      ? SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.isMe
                                  ? AppColors.blueNormal
                                  : AppColors.whiteLight,
                            ),
                          ),
                        )
                      : Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
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
                          // Generate simulated bar heights for waveform effect
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
                          final isPassed = index / 24.0 <= playbackProgress;
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
                          _formatDuration(_position),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: widget.isMe
                                ? AppColors.whiteDark
                                : AppColors.whiteDarker,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatDuration(_duration),
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
        ),
      ],
    );
  }
}
