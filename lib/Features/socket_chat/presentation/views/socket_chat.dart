import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Features/socket_chat/data/models/chat_arguments.dart';
import 'package:motoverse/Features/socket_chat/domain/repo/chat_socket_repo.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_cubit.dart';
import 'package:motoverse/Features/socket_chat/presentation/views/socket_chat_body.dart';

class SocketChat extends StatefulWidget {
  const SocketChat({super.key});

  @override
  State<SocketChat> createState() => _SocketChatState();
}

class _SocketChatState extends State<SocketChat> {

  String chatId = '';
  String chatUserName = '';
  String chatUserId = '';
  String helperAvatar = '';
  bool isHelper = false;
  String requestId = '';
  String offerId = '';
  String averageRating = '';
  bool helperVerified = false;

   
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChatArguments;

    return BlocProvider(
      create: (context) {
        final cubit = SocketChatCubit(
          chatSocketRepo: getIt<ChatSocketRepository>(),
        );
        if (args.chatId.isNotEmpty) {
          cubit.connectToChatRoom(chatId: args.chatId);
          cubit.markChatAsSeen(args.chatId);
        }
        return cubit;
      },
      child: SocketChatBody(
        chatId: args.chatId,
        chatUserId: args.chatUserId,
        chatUserName: args.chatUserName,
        helperAvatar: args.helperAvatar,
        isHelper: args.isHelper,
        requestId: args.requestId,
        offerId: args.offerId,
        averageRating: args.averageRating,
        helperVerified: args.helperVerified,
        isOnline: args.isOnline,
      ),
    );
  }
}