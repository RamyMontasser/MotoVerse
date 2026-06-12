import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  WebSocketChannel? _channel;
  StreamController<dynamic>? _messageStreamController;
  // ignore: unused_field
  bool _isConnecting = false;
  bool _userClosed = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  String? _currentUrl;

  Stream<dynamic> get messagesStream => _messageStreamController?.stream ?? const Stream.empty();

  bool get isConnected => _channel != null && !_userClosed;

  Future<void> connect(String url) async {
    if (_currentUrl == url && isConnected) {
      debugPrint('WebSocket already connected to this URL.');
      return;
    }

    _cleanupConnection();

    _currentUrl = url;
    _userClosed = false;
    _isConnecting = true;
    _reconnectAttempts = 0;
    
    _messageStreamController = StreamController<dynamic>.broadcast();

    await _establishConnection();
  }

  Future<void> _establishConnection() async {
    if (_currentUrl == null || _userClosed) return;

    try {
      debugPrint('Connecting to WebSocket URL: $_currentUrl');
      _channel = WebSocketChannel.connect(Uri.parse(_currentUrl!));
      _isConnecting = false;
      
      _channel!.stream.listen(
        (message) {
          _reconnectAttempts = 0; 
          if (_messageStreamController != null && !_messageStreamController!.isClosed) {
            _messageStreamController!.add(message);
          }
        },
        onError: (error) {
          debugPrint('WebSocket stream error: $error');
          _handleDisconnect();
        },
        onDone: () {
          debugPrint('WebSocket stream done (connection closed).');
          _handleDisconnect();
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('WebSocket connection exception: $e');
      _handleDisconnect();
    }
  }

  void _handleDisconnect() {
    if (_userClosed) return;
    _isConnecting = false;
    
    final delaySeconds = _reconnectAttempts < 6 ? (1 << _reconnectAttempts) : 32;
    _reconnectAttempts++;
    
    debugPrint('WebSocket disconnected. Attempting to reconnect in $delaySeconds seconds (attempt $_reconnectAttempts)...');
    
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: delaySeconds), () {
      _establishConnection();
    });
  }

  void sendMessage(Map<String, dynamic> data) {
    if (_channel != null && !_userClosed) {
      try {
        final jsonStr = jsonEncode(data);
        debugPrint('WebSocket sending payload: $jsonStr');
        _channel!.sink.add(jsonStr);
      } catch (e) {
        debugPrint('Error sending WebSocket message: $e');
      }
    } else {
      debugPrint('WebSocket not connected. Unable to send message: $data');
    }
  }

  void disconnect() {
    debugPrint('WebSocket disconnect requested by client.');
    _userClosed = true;
    _cleanupConnection();
  }

  void _cleanupConnection() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    try {
      _channel?.sink.close();
    } catch (e) {
      debugPrint('Error closing WebSocket channel sink: $e');
    }
    _channel = null;
    _currentUrl = null;
    _isConnecting = false;

    if (_messageStreamController != null && !_messageStreamController!.isClosed) {
      _messageStreamController!.close();
    }
    _messageStreamController = null;
  }
}
