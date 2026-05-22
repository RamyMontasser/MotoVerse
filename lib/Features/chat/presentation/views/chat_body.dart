// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:motoverse/Core/theme/app_colors.dart';
// import 'package:motoverse/Core/widgets/custom_app_dialog.dart';
// import 'package:motoverse/Features/ai_chat/presentation/widgets/message_input.dart';
// import 'package:motoverse/Features/chat/presentation/cubit/chat_cubit.dart';
// import 'package:motoverse/Features/chat/presentation/widgets/chat_app_bar.dart';
// import 'package:motoverse/Features/chat/presentation/widgets/message_bubble.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatBody extends StatefulWidget {
//   final String chatId;
//   final String helperName;
//   final String otherUserId;
//   final bool isHelper;
//   final String? helperAvatar;
//   final String requestId;
//   final String offerId;
//   const ChatBody({
//     super.key,
//     required this.chatId,
//     required this.helperName,
//     required this.otherUserId,
//     required this.isHelper,
//     required this.helperAvatar,
//     required this.requestId,
//     required this.offerId,
//   });

//   @override
//   State<ChatBody> createState() => _ChatBodyState();
// }

// class _ChatBodyState extends State<ChatBody> {
//    final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatCubit>().markChatAsSeen(widget.chatId);
//   }

//   void _sendMessage() {
//     final String chatId = widget.chatId;
//     context.read<ChatCubit>().sendMessage(
//       chatId: chatId,
//       message: _controller.text.trim(),
//     );
//     _scrollToBottom();
//     _controller.clear();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0.0,
//           // _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> deleteChat() async {
//     final chatCubit = context.read<ChatCubit>();
//     if (widget.isHelper) {
//       await chatCubit.completeOfferChat(
//         chatId: widget.chatId,
//         offerId: widget.offerId,
//       );
//       if (mounted) {
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           'main screen',
//           (route) => false,
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (dialogContext) => CustomAppDialog(
//           title: 'إنهاء المحادثة والطلب',
//           desc: 'هل تم حل مشكلتك واكتمال طلبك بنجاح؟',
//           btnText: 'نعم',
//           btnText2: 'لا',
//           onTap: () async {
//             await chatCubit.closeChat(
//               chatId: widget.chatId,
//               solved: true,
//             );
//             if (mounted) {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 'main screen',
//                 (route) => false,
//               );
//             }
//           },
//           onTap2: () async {
//             await chatCubit.closeChat(
//               chatId: widget.chatId,
//               solved: false,
//             );
//             if (mounted) {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 'main screen',
//                 (route) => false,
//               );
//             }
//           },
//         ),
//       );
//     }
//   }


//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: ChatAppBar(
//         name: widget.helperName,
//         status: 'متصل',
//         avatarUrl: widget.helperAvatar,
//         onDeleteChat: () => deleteChat(),
//         isHelper: widget.isHelper,
//       ),
//       bottomSheet: MessageInput(
//         message: _controller,
//         onSend: _sendMessage,
//         isAI: false,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatCubit, ChatState>(
//               buildWhen: (previous, current) => 
//                   current is GetMessagesSuccess || 
//                   current is GetMessagesLoading || 
//                   current is GetMessagesError,
//               builder: (context, state) {
//                 if (state is GetMessagesLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.yellowNormal,
//                     ),
//                   );
//                 }

//                 if (state is GetMessagesSuccess) {
//                   final messages = state.messages;

//                   if (messages.isEmpty) {
//                     return const Center(child: Text('No messages yet'));
//                   }

//                   return ListView.builder(
//                     controller: _scrollController,
//                     reverse: true,
//                     padding: EdgeInsets.symmetric(vertical: 10.h),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];

//                       return MessageBubble(
//                         message: message,
//                         receiverAvatar: widget.helperAvatar,
//                       );
//                     },
//                   );
//                 }

//                 if (state is GetMessagesError) {
//                   return Center(child: Text(state.errorMsg));
//                 }

//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.yellowNormal,
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Expanded(
//           //   child: ListView.builder(
//           //     padding: EdgeInsets.symmetric(vertical: 10.h),
//           //     itemCount: _messages.length,
//           //     itemBuilder: (context, index) {
//           //       return MessageBubble(
//           //         message: _messages[index],
//           //         receiverAvatar: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
//           //       );
//           //     },
//           //   ),
//           // ),
//           // MessageInput(
//           //   message: _controller,
//           //   onSend: _sendMessage, isAI: false,
//           // ),
//           SizedBox(height: 90.h),
//         ],
//       ),
//     );
//   }
// }
