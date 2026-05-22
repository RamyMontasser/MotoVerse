// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:motoverse/Core/services/getit.dart';
// import 'package:motoverse/Features/chat/domain/repo/chat_repo.dart';
// import 'package:motoverse/Features/chat/presentation/cubit/chat_cubit.dart';
// import 'package:motoverse/Features/chat/presentation/views/chat_body.dart';
// import 'package:motoverse/Features/home/data/models/user_model.dart';

// // ignore: must_be_immutable
// class ChatPage extends StatelessWidget {
//   ChatPage({super.key});

//   late String chatId = '';
//   late String helperName;
//   String? helperAvatar;
//   late bool isHelper;
//   late UserDataModel currentUser;
//   late String otherUserId;

//   late String requestId = '';
//   late String offerId = '';

//   String generateChatId(String a, String b) {
//     final ids = [a, b]..sort();
//     return ids.join('_');}

//    @override
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       otherUserId = args['otherUserId'].toString();
//       helperName = args['otherUserName'] ?? '';
//       helperAvatar = args['otherUserAvatar'];
//       isHelper = args['isHelper'] ?? false;
//       requestId = args['requestId']?.toString() ?? '';
//       offerId = args['offerId']?.toString() ?? '';

//       final userBox = Hive.box<UserDataModel>('user_box');
//       currentUser = userBox.get('user')!;
//       final currentUserId =
//           FirebaseAuth.instance.currentUser?.uid ??
//           currentUser.id.toString();
//       chatId = generateChatId(currentUserId, otherUserId);
//     }
//     final currentUserId =
//         FirebaseAuth.instance.currentUser?.uid ??
//         currentUser.id.toString();
//     return BlocProvider(
//       create: (context) => ChatCubit(chatRepo: getIt<ChatRepo>())
//         ..createChat(
//           chatId: chatId,
//           userId: currentUserId,
//           otherUserId: otherUserId,
//           requestId: requestId,
//           offerId: offerId,
//         )
//         ..getMessages(chatId),
//       child: ChatBody(
//         chatId: chatId,
//         helperName: helperName,
//         otherUserId: otherUserId,
//         isHelper: isHelper,
//         helperAvatar: helperAvatar,
//         requestId: requestId,
//         offerId: offerId,
//       ),
//     );
//   }
// }