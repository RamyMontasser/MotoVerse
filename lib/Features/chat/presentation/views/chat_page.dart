import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/message_input.dart';
import 'package:motoverse/Features/chat/data/models/message_model.dart';
import 'package:motoverse/Features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:motoverse/Features/chat/presentation/widgets/message_bubble.dart';
import 'package:motoverse/Features/home/data/models/user_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final fireStore = FirebaseFirestore.instance;

  late String chatId = '';
  late String helperName;
  String? helperAvatar;
  late bool isHelper;
  // =
  //     'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg';

  String generateChatId(String a, String b) {
    final ids = [a, b]..sort();
    return ids.join('_');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final String otherUserId = args['otherUserId'].toString();
      helperName = args['otherUserName'];
      helperAvatar = args['otherUserAvatar'];
      isHelper = args['isHelper'];

      final userBox = Hive.box<UserDataModel>('user_box');
      final currentUser = userBox.get('user');
      chatId = generateChatId(currentUser!.id.toString(), otherUserId);

      fireStore.collection('chats').doc(chatId).set({
        "participants": ["${currentUser.id}", otherUserId],
      }, SetOptions(merge: true));
    }
    // else {
    // // Fallback for direct navigation if any
    // final userBox = Hive.box<UserDataModel>('user_box');
    // final currentUser = userBox.get('user');
    // chatId = generateChatId(currentUser!.id.toString(), "2");
    // fireStore.collection('chats').doc(chatId).set({
    //   "participants": ["${currentUser.id}", "2"],
    // }, SetOptions(merge: true));
    // }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    if (chatId.isEmpty) return;

    await fireStore.collection('chats').doc(chatId).collection('messages').add({
      "senderId": FirebaseAuth.instance.currentUser!.uid,
      "text": _controller.text.trim(),
      "timestamp": FieldValue.serverTimestamp(),
    });
    _scrollToBottom();
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 3),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> deleteChat(String chatId) async {
    final messages = await fireStore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();
    for (var message in messages.docs) {
      await message.reference.delete();
    }
    await fireStore.collection('chats').doc(chatId).delete();
    // await fireStore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('chats').doc(chatId).delete();
  }

  @override
  void initState() {
    super.initState();
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
        name: helperName,
        status: 'متصل',
        avatarUrl: helperAvatar, 
        onDeleteChat: () => deleteChat(chatId),
        isHelper: isHelper,
      ),
      bottomSheet: MessageInput(
        message: _controller,
        onSend: _sendMessage,
        isAI: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowNormal,
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index];

                    final isMe =
                        data['senderId'] ==
                        FirebaseAuth.instance.currentUser!.uid;

                    return MessageBubble(
                      message: MessageModel(
                        senderId: data['senderId'],
                        text: data['text'],
                        timestamp:
                            (data['timestamp'] as Timestamp?)?.toDate() ??
                            DateTime.now(),
                        isMe: isMe,
                      ),
                      receiverAvatar:
                          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                    );
                  },
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
