import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/message_input.dart';
import 'package:motoverse/Features/chat/presentation/cubit/chat_cubit.dart';
import 'package:motoverse/Features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:motoverse/Features/chat/presentation/widgets/message_bubble.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatefulWidget {
  final String chatId;
  final String helperName;
  final String otherUserId;
  final bool isHelper;
  final String? helperAvatar;
  const ChatBody({
    super.key,
    required this.chatId,
    required this.helperName,
    required this.otherUserId,
    required this.isHelper,
    required this.helperAvatar,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
   final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // final fireStore = FirebaseFirestore.instance;

  // late String chatId = '';
  // late String helperName;
  // String? helperAvatar;
  // late bool isHelper;
  // =
  //     'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg';

  // String generateChatId(String a, String b) {
  //   final ids = [a, b]..sort();
  //   return ids.join('_');
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //   if (args != null) {
  //     final String otherUserId = args['otherUserId'].toString();
  //     helperName = args['otherUserName'];
  //     helperAvatar = args['otherUserAvatar'];
  //     isHelper = args['isHelper'];

  //     final userBox = Hive.box<UserDataModel>('user_box');
  //     final currentUser = userBox.get('user');
  //     chatId = generateChatId(currentUser!.id.toString(), otherUserId);

  //     fireStore.collection('chats').doc(chatId).set({
  //       "participants": ["${currentUser.id}", otherUserId],
  //     }, SetOptions(merge: true));
  //   }
  //   // else {
  //   // // Fallback for direct navigation if any
  //   // final userBox = Hive.box<UserDataModel>('user_box');
  //   // final currentUser = userBox.get('user');
  //   // chatId = generateChatId(currentUser!.id.toString(), "2");
  //   // fireStore.collection('chats').doc(chatId).set({
  //   //   "participants": ["${currentUser.id}", "2"],
  //   // }, SetOptions(merge: true));
  //   // }
  // }

  void _sendMessage() {
    final String chatId = widget.chatId;
    context.read<ChatCubit>().sendMessage(chatId, _controller.text.trim());
    // if (_controller.text.trim().isEmpty) return;
    // if (chatId.isEmpty) return;

    // await fireStore.collection('chats').doc(chatId).collection('messages').add({
    //   "senderId": FirebaseAuth.instance.currentUser!.uid,
    //   "text": _controller.text.trim(),
    //   "timestamp": FieldValue.serverTimestamp(),
    // });
    _scrollToBottom();
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          // _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> deleteChat() async {
    final String chatId = widget.chatId;
    context.read<ChatCubit>().deleteChat(chatId);
    // final messages = await fireStore
    //     .collection('chats')
    //     .doc(chatId)
    //     .collection('messages')
    //     .get();
    // for (var message in messages.docs) {
    //   await message.reference.delete();
    // }
    // await fireStore.collection('chats').doc(chatId).delete();
    // await fireStore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('chats').doc(chatId).delete();
  }


  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ChatAppBar(
        name: widget.helperName,
        status: 'متصل',
        avatarUrl: widget.helperAvatar,
        onDeleteChat: () => deleteChat(),
        isHelper: widget.isHelper,
      ),
      bottomSheet: MessageInput(
        message: _controller,
        onSend: _sendMessage,
        isAI: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (previous, current) => 
                  current is GetMessagesSuccess || 
                  current is GetMessagesLoading || 
                  current is GetMessagesError,
              builder: (context, state) {
                if (state is GetMessagesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowNormal,
                    ),
                  );
                }

                if (state is GetMessagesSuccess) {
                  final messages = state.messages;

                  if (messages.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return MessageBubble(
                        message: message,
                        receiverAvatar: widget.helperAvatar,
                      );
                    },
                  );
                }

                if (state is GetMessagesError) {
                  return Center(child: Text(state.errorMsg));
                }

                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowNormal,
                  ),
                );
              },
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     padding: EdgeInsets.symmetric(vertical: 10.h),
          //     itemCount: _messages.length,
          //     itemBuilder: (context, index) {
          //       return MessageBubble(
          //         message: _messages[index],
          //         receiverAvatar: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
          //       );
          //     },
          //   ),
          // ),
          // MessageInput(
          //   message: _controller,
          //   onSend: _sendMessage, isAI: false,
          // ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }
}
