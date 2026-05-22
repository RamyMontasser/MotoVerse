# Audio Message Playback - Quick Reference

## Quick Integration Guide

### For Chat Messages (Already Implemented ✅)

Audio messages are automatically handled in `SocketMessageBubble`:

```dart
// In socket_message_bubble.dart
if (message.type == 'audio')
  Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: AudioPlayerWidget(
      audioUrl: message.audioUrl,
      isMe: message.isMe,
    ),
  ),
```

### For Custom Screens

Use `AudioPlayerWidget` anywhere in your app:

```dart
import 'package:motoverse/Features/socket_chat/presentation/widgets/audio_player_widget.dart';

// In your widget
AudioPlayerWidget(
  audioUrl: 'https://example.com/audio.mp3',
  isMe: false,
  width: 280.w, // optional
  onStateChanged: () {
    debugPrint('Playback state changed');
  },
)
```

## Message Model

Audio messages use `TextMessageModel`:

```dart
TextMessageModel(
  messageId: 'msg_123',
  type: 'audio', // Important: must be 'audio'
  message: '', // Usually empty for audio-only messages
  audioUrl: '/media/audio/message_123.mp3', // or full URL
  senderId: 'user_456',
  senderName: 'John Doe',
  timestamp: DateTime.now(),
  isMe: true,
  isSeen: true,
)
```

## Sending Audio Messages

From `SocketMessageInput`:

```dart
// Record audio first
final audioPath = await _audioRecorder.stop();

// Send via cubit
context.read<SocketChatCubit>().sendMediaMessage(
  chatId: chatId,
  filePath: audioPath,
  fileType: 'audio', // Key parameter
)
```

## Handling Audio URLs

### URL Formats Supported

```dart
// Absolute URL (used as-is)
audioUrl: 'https://api.motoverse.com/media/audio/msg_123.mp3'

// Relative URL (prepends AppConstants.baseUrl)
audioUrl: '/media/audio/msg_123.mp3'
audioUrl: 'media/audio/msg_123.mp3'

// Full URL without domain (prepends AppConstants.baseUrl)
audioUrl: 'api/v1/media/audio/msg_123.mp3'
```

### Backend Response Format

```json
{
  "message_id": "msg_123",
  "message_type": "audio",
  "type": "audio",
  "audio": "/media/audio/message_123.mp3",
  "audio_url": "/media/audio/message_123.mp3",
  "sender_id": 456,
  "sender_name": "John Doe",
  "timestamp": "2024-05-22T14:30:00Z",
  "is_seen": true
}
```

## Widget State Management

### Listen to Playback Changes

```dart
AudioPlayerWidget(
  audioUrl: audioUrl,
  isMe: isMe,
  onStateChanged: () {
    // Called whenever:
    // - Play starts
    // - Pause is triggered
    // - Audio finishes
    // - Error occurs
  },
)
```

### Manual Player Control (If Needed)

The widget is self-contained, but you can access state through callbacks:

```dart
class MyAudioListenerWidget extends StatefulWidget {
  @override
  State<MyAudioListenerWidget> createState() => _MyAudioListenerWidgetState();
}

class _MyAudioListenerWidgetState extends State<MyAudioListenerWidget> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AudioPlayerWidget(
          audioUrl: 'https://example.com/audio.mp3',
          isMe: true,
          onStateChanged: () {
            setState(() {
              _isPlaying = !_isPlaying; // Example
            });
          },
        ),
        if (_isPlaying)
          Text('Now Playing...'),
      ],
    );
  }
}
```

## Styling & Customization

### Change Colors

Edit `audio_player_widget.dart`:

```dart
final waveColor = widget.isMe
    ? AppColors.whiteDark.withValues(alpha: 0.5)
    : AppColors.whiteDarker.withValues(alpha: 0.3);

final waveActiveColor = widget.isMe
    ? AppColors.yellowNormal // Change this
    : AppColors.blueNormal;  // Or this
```

### Change Widget Size

```dart
AudioPlayerWidget(
  audioUrl: audioUrl,
  isMe: isMe,
  width: 280.w, // Default is 240.w
)
```

### Adjust Waveform Visualization

In `audio_player_widget.dart`, modify the `heights` array:

```dart
final heights = [
  4, 8, 15, 12, 6, 18, 22, 10, 5, 9, 14, 20,
  16, 7, 11, 24, 13, 8, 4, 10, 15, 7, 12, 6,
];
// Change values for different visual effect
```

## Error Scenarios & Handling

### Invalid URL
```
Error message: "Invalid audio URL"
```

### Network Error
```
Error message: "Error: Failed host lookup"
or other network-related error
```

### Permissions Issue
```
Error message: "Error: Permission denied"
```

The widget displays these errors gracefully without crashing the app.

## Performance Tips

1. **Don't Pre-load All Audio**: Audio is loaded on-demand when user presses play
2. **Single Player Instance**: One AudioPlayer per widget ensures efficient resource use
3. **Proper Cleanup**: Widget automatically disposes resources when removed
4. **Lazy Loading**: Duration only fetched when audio starts playing

## WebSocket Message Flow

```
1. Backend sends audio message via WebSocket
   ↓
2. SocketService receives message
   ↓
3. ChatSocketRepository parses to TextMessageModel
   ↓
4. SocketChatCubit emits SocketMessagesSuccess
   ↓
5. SocketMessageBubble displays AudioPlayerWidget
   ↓
6. User taps play → AudioPlayer downloads & plays audio
```

## Debugging

Enable debug prints in `audio_player_widget.dart`:

```dart
// Add this in onInitState
_audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  debugPrint('Audio State: $state');
  if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
});

_audioPlayer.onDurationChanged.listen((Duration d) {
  debugPrint('Duration: ${d.inSeconds}s');
  if (mounted) setState(() => _duration = d);
});

_audioPlayer.onPositionChanged.listen((Duration p) {
  debugPrint('Position: ${p.inSeconds}s');
  if (mounted) setState(() => _position = p);
});
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Audio doesn't play | Check URL is accessible, network connectivity |
| Duration shows 00:00 | Wait for audio to load, check file size |
| Widget rebuilds too often | Verify mounted checks in listeners |
| Audio keeps playing | Ensure dispose() is called properly |
| No sound output | Check device volume, audio permissions |

## Testing Audio Playback

```bash
# Run your app
flutter run

# Navigate to chat screen
# Send/receive audio message
# Tap play button
# Verify audio plays through device speakers/headphones
```

## Code Examples Repository

All examples and more detailed code can be found in:
- Implementation: `lib/Features/socket_chat/presentation/widgets/audio_player_widget.dart`
- Integration: `lib/Features/socket_chat/presentation/widgets/socket_message_bubble.dart`
- Documentation: `AUDIO_PLAYBACK_IMPLEMENTATION.md`
