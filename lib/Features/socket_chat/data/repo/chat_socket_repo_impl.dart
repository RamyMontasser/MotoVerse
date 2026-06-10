import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';
import 'package:motoverse/Features/socket_chat/data/models/file_message_model.dart';
import 'package:motoverse/Features/socket_chat/data/models/text_message_model.dart';
import 'package:motoverse/Features/socket_chat/domain/repo/chat_socket_repo.dart';
import 'package:motoverse/Core/services/socket_service.dart';

class ChatSocketRepositoryImpl implements ChatSocketRepository {
  final SocketService socketService;
  final NetworkService networkService;

  ChatSocketRepositoryImpl({
    required this.socketService,
    required this.networkService,
  });

  String _currentUserId = '';
  final List<TextMessageModel> _messages = [];
  StreamController<List<TextMessageModel>>? _messagesController;
  StreamSubscription? _socketSubscription;

  @override
  Future<Either<Failure, void>> connectToChat({
    required String chatId,
    required String token,
  }) async {
    try {
      final userBox = Hive.box<UserDataModel>('user_box');
      final currentUser = userBox.get('user');

      _currentUserId = currentUser?.id.toString() ?? '';

      if (_currentUserId.isEmpty) {
        return left(
          ServerFailure(errorMsg: 'تعذر العثور على بيانات المستخدم المحلية.'),
        );
      }

      if (_messagesController == null || _messagesController!.isClosed) {
        _messagesController =
            StreamController<List<TextMessageModel>>.broadcast();
      }

      final url = _buildWebSocketUrl(chatId, token);
      await socketService.connect(url);

      _socketSubscription?.cancel();
      _socketSubscription = socketService.messagesStream.listen(
        _handleIncomingWebSocketMessage,
        onError: (error) {
          debugPrint('WebSocket stream error: $error');
        },
      );

      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  void _handleIncomingWebSocketMessage(dynamic rawMessage) {
    try {
      debugPrint('WebSocket received message payload: $rawMessage');
      final Map<String, dynamic> decoded = jsonDecode(rawMessage.toString());

      if (decoded.containsKey('messages') && decoded['messages'] is List) {
        final List<dynamic> histList = decoded['messages'];
        for (var item in histList) {
          if (item is Map<String, dynamic>) {
            final msg = TextMessageModel.fromJson(item, _currentUserId);
            _addOrUpdateMessage(msg);
          }
        }
      } else {
        final socketMsg = TextMessageModel.fromJson(decoded, _currentUserId);
        _addOrUpdateMessage(socketMsg);
      }
    } catch (e) {
      debugPrint('Error parsing raw WebSocket event: $e');
    }

    _messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (_messagesController != null && !_messagesController!.isClosed) {
      _messagesController!.add(List<TextMessageModel>.from(_messages));
    }
  }

  // @override
  // void disconnect() {
  //   _socketSubscription?.cancel();
  //   _socketSubscription = null;
  //   socketService.disconnect();
  //   _messagesController?.close();
  //   _messagesController = null;
  // }

  @override
  void disconnect() {
    _socketSubscription?.cancel();
    _socketSubscription = null;

    socketService.disconnect();

    _messages.clear();

    _messagesController?.close();
    _messagesController = null;
  }

  @override
  Stream<List<TextMessageModel>> getMessagesStream() {
    if (_messagesController == null || _messagesController!.isClosed) {
      _messagesController =
          StreamController<List<TextMessageModel>>.broadcast();
    }
    Future.delayed(Duration.zero, () {
      if (_messagesController != null && !_messagesController!.isClosed) {
        _messagesController!.add(List<TextMessageModel>.from(_messages));
      }
    });
    return _messagesController!.stream;
  }

  void _addOrUpdateMessage(TextMessageModel msg) {
    final idx = _messages.indexWhere((m) => m.messageId == msg.messageId);
    if (idx != -1) {
      _messages[idx] = msg;
    } else {
      _messages.add(msg);
    }
  }

  @override
  Future<Either<Failure, List<TextMessageModel>>> getConversationHistory({
    required String chatId,
  }) async {
    try {
      final response = await networkService.getData(
        endPoint: '/chat/conversations/$chatId/messages/',
      );

      final List<TextMessageModel> historyMsgs = [];
      if (response is List) {
        for (var item in response) {
          if (item is Map<String, dynamic>) {
            final msg = TextMessageModel.fromJson(item, _currentUserId);
            historyMsgs.add(msg);
            _addOrUpdateMessage(msg);
          }
        }
      }

      _messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      if (_messagesController != null && !_messagesController!.isClosed) {
        _messagesController!.add(List<TextMessageModel>.from(_messages));
      }

      return right(historyMsgs);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String text,
    String type = 'text',
    String? imageUrl,
    String? audioUrl,
  }) async {
    try {
      socketService.sendMessage({
        'type': type,
        'message': text,
        'image': imageUrl,
        'audio': audioUrl,
      });
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markChatAsSeen(String chatId) async {
    try {
      socketService.sendMessage({'type': 'seen', 'chat_id': chatId});
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOfferChat({
    required String chatId,
    required String offerId,
  }) async {
    try {
      socketService.sendMessage({
        'type': 'complete_offer',
        'chat_id': chatId,
        'offer_id': offerId,
      });
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> closeChat({
    required String chatId,
    required bool solved,
  }) async {
    try {
      socketService.sendMessage({
        'type': 'close_chat',
        'chat_id': chatId,
        'solved': solved,
      });
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeRequest({
    required String requestId,
  }) async {
    try {
      await networkService.addData(
        endPoint: '${AppConstants.communityRequests}$requestId/complete/',
        data: {},
      );
      return right(null);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile({
    required FileMessageModel fileMessage,
  }) async {
    try {
      final formData = await fileMessage.toFormData();

      final response = await networkService.addFormData(
        endPoint: '/chat/upload/',
        data: formData,
      );

      if (response is Map) {
        final fileUrl =
            response['file']?.toString() ??
            response['url']?.toString() ??
            response['path']?.toString() ??
            '';
        return right(fileUrl);
      }
      return left(
        ServerFailure(errorMsg: 'فشل رفع الملف. استجابة غير صالحة من السيرفر.'),
      );
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  String _buildWebSocketUrl(String chatId, String token) {
    final base = AppConstants.baseUrl;
    final cleanBase = base
        .replaceAll('https://', 'wss://')
        .replaceAll('http://', 'ws://');
    final formattedBase = cleanBase.endsWith('/')
        ? cleanBase.substring(0, cleanBase.length - 1)
        : cleanBase;
    return '$formattedBase/ws/chat/$chatId/?token=$token';
  }
}
