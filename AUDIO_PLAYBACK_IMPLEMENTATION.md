# Audio Message Playback Implementation

This document explains the audio message playback feature implemented using the `audioplayers` package.

## Overview

The audio playback feature allows users to play audio messages in the chat interface with a beautiful UI that includes:
- Play/Pause button with animated loading state
- Waveform visualization showing audio progress
- Current time and total duration display
- Error handling for invalid or unreachable audio URLs
- Full lifecycle management (init, playing, pausing, disposing)

## Architecture

### 1. **AudioPlayerWidget** (`audio_player_widget.dart`)
A reusable, stateful widget that encapsulates all audio playback functionality.

**Key Features:**
- Manages `AudioPlayer` instance lifecycle
- Listens to player state changes (playing, paused, stopped)
- Tracks audio duration and current position
- Handles URL loading (supports both absolute URLs and relative paths)
- Displays loading and error states

**Usage:**
```dart
AudioPlayerWidget(
  audioUrl: message.audioUrl,
  isMe: isCurrentUserMessage,
  width: 240.w, // optional
  onStateChanged: () {
    // Called whenever playback state changes
  },
)
```

### 2. **Integration in SocketMessageBubble** (`socket_message_bubble.dart`)
The audio widget is integrated into the message bubble where audio messages are rendered.

**Implementation:**
```dart
if (message.type == 'audio')
  Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: AudioPlayerWidget(
      audioUrl: message.audioUrl,
      isMe: message.isMe,
    ),
  ),
```

### 3. **Message Model**
The `TextMessageModel` already includes the necessary fields:
- `type`: Set to `'audio'` for audio messages
- `audioUrl`: The URL or path to the audio file

## How It Works

### Audio Loading and Playing
1. When the user taps the play button, the widget checks if the audio has already been loaded
2. If not loaded, it constructs the full URL:
   - Absolute URLs (starting with 'http') are used as-is
   - Relative paths are prefixed with `AppConstants.baseUrl`
3. The `AudioPlayer` plays the audio via `UrlSource`
4. The player emits state changes and position updates in real-time

### UI Updates
- **Duration**: Displayed as the total audio length once loaded
- **Position**: Updates in real-time as audio plays
- **Progress**: Waveform bars are colored based on playback progress
- **Playback Button**: Shows loading indicator during initial load, then play/pause icons

### Error Handling
- Invalid audio URLs display an error message below the player
- Network errors are caught and displayed to the user
- The player gracefully handles these errors without crashing

## Dependencies

The implementation uses:
- **audioplayers: ^6.6.0** - For audio playback
- **flutter_screenutil: ^5.9.3** - For responsive sizing
- **Material & Flutter** - For UI components

## File Structure

```
lib/Features/socket_chat/presentation/widgets/
├── audio_player_widget.dart       # Reusable audio player widget
├── socket_message_bubble.dart    # Integrates audio widget
└── socket_message_input.dart     # Audio recording/sending
```

## Usage in Other Widgets

You can use `AudioPlayerWidget` anywhere in your app:

```dart
// In any widget
AudioPlayerWidget(
  audioUrl: 'https://example.com/audio/message.mp3',
  isMe: false, // Colors change based on sender
  width: 250.w,
  onStateChanged: () {
    print('Audio state changed');
  },
)
```

## Lifecycle Management

### Initialization
1. `AudioPlayer` instance is created
2. Animation controller for pulse effect is initialized
3. Event listeners are attached

### During Playback
1. Player state changes trigger widget rebuilds
2. Position updates are streamed and reflected in UI
3. Duration is fetched once audio loads

### Cleanup
1. Audio player is disposed when widget is removed
2. Animation controller is disposed
3. All listeners are automatically cleaned up

## Customization

### Styling
The widget uses `AppColors` for theming:
- `isMe = true`: Uses blue/yellow accent colors
- `isMe = false`: Uses grey/blue accent colors

Modify colors in `AudioPlayerWidget.build()`:
```dart
final waveColor = widget.isMe
    ? AppColors.whiteDark.withValues(alpha: 0.5)
    : AppColors.whiteDarker.withValues(alpha: 0.3);
```

### Waveform Visualization
The waveform consists of 24 bars with predefined heights:
```dart
final heights = [
  4, 8, 15, 12, 6, 18, 22, 10, 5, 9, 14, 20,
  16, 7, 11, 24, 13, 8, 4, 10, 15, 7, 12, 6,
];
```

Modify these values for different visual effects.

### Time Format
Currently uses MM:SS format. Modify `_formatDuration()` for other formats:
```dart
String _formatDuration(Duration duration) {
  // Custom formatting logic
}
```

## Best Practices

1. **Memory Management**: Audio players are disposed properly. Only one player per message is created.
2. **Network Optimization**: Audio files are loaded on-demand (not pre-loaded).
3. **UI Responsiveness**: All state changes use `setState()` with mounted checks.
4. **Error Feedback**: Users see clear error messages for failed playbacks.
5. **Reusability**: `AudioPlayerWidget` is a standalone component that can be used anywhere.

## Testing

To test audio playback:

1. Send an audio message with a valid URL
2. Verify the message displays with the audio player
3. Test play/pause functionality
4. Verify duration and position updates
5. Test with invalid URLs to verify error handling
6. Test disposing (navigate away from chat)

## Future Enhancements

Possible improvements:
- [ ] Add playback speed controls
- [ ] Add seek bar for manual position adjustment
- [ ] Display audio file name/metadata
- [ ] Add visual feedback for audio loading from cache
- [ ] Support for downloading audio files
- [ ] Add equalizer or audio effects
- [ ] Implement audio visualization with actual frequency data
