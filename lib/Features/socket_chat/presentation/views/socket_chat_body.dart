import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_app_dialog.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_cubit.dart';
import 'package:motoverse/Features/socket_chat/presentation/cubit/socket_chat_state.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/chat_app_bar.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/socket_message_bubble.dart';
import 'package:motoverse/Features/socket_chat/presentation/widgets/socket_message_input.dart';

class SocketChatBody extends StatefulWidget {
  final String chatId;
  final String otherUserId;
  final String helperName;
  final String? helperAvatar;
  final bool isHelper;
  final String requestId;
  final String offerId;
  final String averageRating;
  final bool helperVerified;

  const SocketChatBody({
    super.key, required this.chatId, required this.otherUserId, required this.helperName, this.helperAvatar, required this.isHelper, required this.requestId, required this.offerId, required this.averageRating, required this.helperVerified,});

  @override
  State<SocketChatBody> createState() => _SocketChatBodyState();
}

class _SocketChatBodyState extends State<SocketChatBody> {
  final ScrollController _scrollController = ScrollController();

  // String chatId = '';
  // String helperName = '';
  // String? helperAvatar;
  // bool isHelper = false;
  // String otherUserId = '';
  // String requestId = '';
  // String offerId = '';
  // String averageRating = '';
  // bool helperVerified = false;
  // bool _isInit = true;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInit) {
  //     final args =
  //         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //     if (args != null) {
  //       chatId = args['chatId']?.toString() ?? '';
  //       otherUserId = args['otherUserId']?.toString() ?? '';
  //       helperName = args['otherUserName'] ?? '';
  //       helperAvatar = args['otherUserAvatar'];
  //       isHelper = args['isHelper'] ?? false;
  //       requestId = args['requestId']?.toString() ?? '';
  //       offerId = args['offerId']?.toString() ?? '';
  //       averageRating = args['averageRating']?.toString() ?? '';
  //       helperVerified = args['helperVerified'] ?? false;

  //       if (chatId.isNotEmpty) {
  //         context.read<SocketChatCubit>().connectToChatRoom(chatId: chatId);
  //         context.read<SocketChatCubit>().markChatAsSeen(chatId);
  //       }
  //     }
  //     _isInit = false;
  //   }
  // }

  Future<void> _confirmCompleteRequest() async {
      final shouldComplete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => CustomAppDialog(
        title: 'تأكيد إنهاء الطلب',
        desc:
            'بمجرد انهاء الطلب، لن تتمكن من التواصل مع الطرف الآخر عبر هذه المحادثة. هل أنت متأكد أنك تريد إنهاء الطلب؟',
        btnText: 'نعم',
        onTap: () => Navigator.of(dialogContext).pop(true),
        btnText2: 'لا',
        onTap2: () => Navigator.of(dialogContext).pop(false),
      ),
    );

    if (shouldComplete != true) return;

    context.read<SocketChatCubit>().completeRequest(requestId: widget.requestId);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.cairoMedium12.copyWith(color: AppColors.whiteLight),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.blueNormal,
      ),
    );
  }

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
        name: widget.helperName,
        status: 'متصل',
        avatarUrl: widget.helperAvatar,
        onDeleteChat: widget.isHelper ? () {} : _confirmCompleteRequest,
        isHelper: widget.isHelper,
        helperVerified: widget.helperVerified,
      ),
      bottomSheet: SocketMessageInput(chatId: widget.chatId),
      body: BlocListener<SocketChatCubit, SocketChatState>(
        listenWhen: (previous, current) =>
            current is SocketRequestCompleteSuccess ||
            current is SocketRequestCompleteError,
        listener: (context, state) {
          if (state is SocketRequestCompleteSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'ReviewScreen',
              (route) => false,
              arguments: {'offerId': int.tryParse(widget.offerId) ?? 0},
            );
          } else if (state is SocketRequestCompleteError) {
            _showSnackBar(state.errorMsg);
          }
        },
        child: Column(
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
                  if (state is SocketChatConnectLoading ||
                      state is SocketMessagesLoading) {
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
                      padding: EdgeInsets.only(
                        top: 10.h,
                        bottom: 85.h,
                        left: 2.w,
                        right: 2.w,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return SocketMessageBubble(
                          message: message,
                          receiverAvatar: widget.helperAvatar,
                        );
                      },
                    );
                  }

                  if (state is SocketMessagesError) {
                    return Center(
                      child: Text(
                        state.errorMsg,
                        style: const TextStyle(color: AppColors.redNormal),
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowNormal,
                    ),
                  );
                },
              ),
            ),
            // SizedBox(height: 90.h),
          ],
        ),
      ),
    );
  }
}
