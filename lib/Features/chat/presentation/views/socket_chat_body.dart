import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart';
import 'package:motoverse/Core/widgets/custom_app_dialog.dart';
import 'package:motoverse/Features/chat/presentation/cubit/socket_chat_cubit.dart';
import 'package:motoverse/Features/chat/presentation/cubit/socket_chat_state.dart';
import 'package:motoverse/Features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:motoverse/Features/chat/presentation/widgets/socket_message_bubble.dart';
import 'package:motoverse/Features/chat/presentation/widgets/socket_message_input.dart';
import 'package:motoverse/generated/l10n.dart';

class SocketChatBody extends StatefulWidget {
  final String chatId;
  final String chatUserId;
  final String chatUserName;
  final String? helperAvatar;
  final bool isHelper;
  final String requestId;
  final String offerId;
  final String averageRating;
  final bool helperVerified;
  final bool isOnline;
  const SocketChatBody({
    super.key,
    required this.chatId,
    required this.chatUserId,
    required this.chatUserName,
    this.helperAvatar,
    required this.isHelper,
    required this.requestId,
    required this.offerId,
    required this.averageRating,
    required this.helperVerified,
    required this.isOnline,
  });

  @override
  State<SocketChatBody> createState() => _SocketChatBodyState();
}

class _SocketChatBodyState extends State<SocketChatBody> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _confirmCompleteRequest() async {
    final shouldComplete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => CustomAppDialog(
        title: S.of(dialogContext).confirmCompleteRequestTitle,
        desc: S.of(dialogContext).confirmCompleteRequestDesc,
        btnText: S.of(dialogContext).yes,
        onTap: () => Navigator.of(dialogContext).pop(true),
        btnText2: S.of(dialogContext).no,
        onTap2: () => Navigator.of(dialogContext).pop(false),
      ),
    );

    if (shouldComplete != true) return;

    context.read<SocketChatCubit>().completeRequest(
      requestId: widget.requestId,
    );
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
    debugPrint('the user user status : ${widget.isOnline}');
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<SocketChatCubit>().disconnectFromChat();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ChatAppBar(
          name: widget.chatUserName,
          status: widget.isOnline
              ? S.of(context).online
              : S.of(context).offline,
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
                        return Center(child: Text(S.of(context).noMessagesYet));
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
            ],
          ),
        ),
      ),
    );
  }
}
