import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/socket_message_input.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_cubit.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_state.dart';
import 'package:motoverse/Features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/socket_message_bubble.dart';

class SocketChatBody extends StatefulWidget {
  // final String chatId;
  // final String helperName;
  // final String otherUserId;
  // final bool isHelper;
  // final String? helperAvatar;
  // final String requestId;
  // final String offerId;

  const SocketChatBody({
    super.key,
    // required this.chatId,
    // required this.helperName,
    // required this.otherUserId,
    // required this.isHelper,
    // required this.helperAvatar,
    // required this.requestId,
    // required this.offerId,
  });

  @override
  State<SocketChatBody> createState() => _SocketChatBodyState();
}

class _SocketChatBodyState extends State<SocketChatBody> {
  final ScrollController _scrollController = ScrollController();

  String chatId = '';
  String helperName = '';
  String? helperAvatar;
  bool isHelper = false;
  String otherUserId = '';
  String requestId = '';
  String offerId = '';

  bool _isInit = true;

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        chatId = args['chatId']?.toString() ?? '';
        otherUserId = args['otherUserId']?.toString() ?? '';
        helperName = args['otherUserName'] ?? '';
        helperAvatar = args['otherUserAvatar'];
        isHelper = args['isHelper'] ?? false;
        requestId = args['requestId']?.toString() ?? '';
        offerId = args['offerId']?.toString() ?? '';

        if (chatId.isNotEmpty) {
          final cubit = context.read<SocketChatCubit>();
          
          cubit.markChatAsSeen(chatId);
          
          cubit.connectToChatRoom(chatId: chatId); 
        }
      }
      _isInit = false; 
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<SocketChatCubit>().markChatAsSeen(chatId);
  // }



  // Future<void> deleteChat() async {
  //   final socketChatCubit = context.read<SocketChatCubit>();
  //   if (isHelper) {
  //     await socketChatCubit.completeOfferChat(
  //       chatId: chatId,
  //       offerId: offerId,
  //     );
  //     if (mounted) {
  //       Navigator.pushNamedAndRemoveUntil(
  //         context,
  //         'main screen',
  //         (route) => false,
  //       );
  //     }
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (dialogContext) => CustomAppDialog(
  //         title: 'إنهاء المحادثة والطلب',
  //         desc: 'هل تم حل مشكلتك واكتمال طلبك بنجاح؟',
  //         btnText: 'نعم',
  //         btnText2: 'لا',
  //         onTap: () async {
  //           await socketChatCubit.closeChat(
  //             chatId: chatId,
  //             solved: true,
  //           );
  //           if (mounted) {
  //             Navigator.pushNamedAndRemoveUntil(
  //               context,
  //               'main screen',
  //               (route) => false,
  //             );
  //           }
  //         },
  //         onTap2: () async {
  //           await socketChatCubit.closeChat(
  //             chatId: chatId,
  //             solved: false,
  //           );
  //           if (mounted) {
  //             Navigator.pushNamedAndRemoveUntil(
  //               context,
  //               'main screen',
  //               (route) => false,
  //             );
  //           }
  //         },
  //       ),
  //     );
  //   }
  // }

  @override
  void dispose() {
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
        onDeleteChat: (){},
        // () => deleteChat(),
        isHelper: isHelper,
      ),
      bottomSheet: SocketMessageInput(
        chatId: chatId,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SocketChatCubit, SocketChatState>(
  buildWhen: (previous, current) =>
      current is SocketMessagesLoading ||
      current is SocketMessagesSuccess ||
      current is SocketMessagesError ||
      current is SocketChatConnectLoading || 
      current is SocketChatConnectError,
  builder: (context, state) {
    if (state is SocketChatConnectLoading || state is SocketMessagesLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.yellowNormal,
        ),
      );
    }

    if (state is SocketChatConnectError) {
      return Center(
        child: Text(
          state.errorMsg,
          style: const TextStyle(color: AppColors.redNormal),
        ),
      );
    }

    if (state is SocketMessagesSuccess) {
      final messages = state.messages;

      if (messages.isEmpty) {
        return const Center(child: Text('لا توجد رسائل بعد'));
      }

      return ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: EdgeInsets.only(top: 10.h, bottom: 85.h, left: 2.w, right: 2.w),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return SocketMessageBubble(
            message: message,
            receiverAvatar: helperAvatar,
          );
        },
      );
    }

    if (state is SocketMessagesError) {
      return Center(child: Text(state.errorMsg,style: const TextStyle(color: AppColors.redNormal),));
    }

    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.yellowNormal,
      ),
    );
  },
)
          ),
          // SizedBox(height: 90.h),
        ],
      ),
    );
  }
}
