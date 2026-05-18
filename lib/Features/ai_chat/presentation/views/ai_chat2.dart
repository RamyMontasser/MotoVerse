import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/chat_welcome.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/message.dart';
import 'package:motoverse/Features/ai_chat/presentation/widgets/message_input.dart';

class AiChat2 extends StatefulWidget {
  const AiChat2({super.key});

  @override
  State<AiChat2> createState() => _AiChat2State();
}

class _AiChat2State extends State<AiChat2> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> messageList = [];
  final TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // bottomSheet:
      body: Column(
        children: [
          Expanded(
            child: CustomScrollViewWithAppBar(
              controller: _scrollController,
              
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: messageList.isEmpty
                        ? ChatWelcome()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return Message(
                                messageContent: messageList[index],
                              );
                            },
                          ),
                  ),
                ),
              
            ),
          Form(
            key: _formKey,
            child: MessageInput(
              message: messageController,
              onSend: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    messageList.add(messageController.text);
                    messageController.clear();
                  });
                  _scrollToBottom();
                }
              }, isAI: true,
            ),
          ),
        ],
      ),
    );
  }
}
