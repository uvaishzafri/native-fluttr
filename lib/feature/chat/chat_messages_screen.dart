import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as flutterchat;
import 'package:native/repo/model/message.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

@RoutePage()
class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({super.key, required this.chatRoomDocId});
  final String chatRoomDocId;
  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  // List<Chat> _chats = [];
  // TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    // _searchController = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final chatCubit = BlocProvider<ChatCubit>.value(value: getIt<ChatCubit>());
    //   chatCubit.getChatMessages(widget.chatRoomDocId);
    // });
  }

  @override
  void dispose() {
    // _searchController?.dispose();
    super.dispose();
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: '',
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.TextMessage message) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit.createChatMessage(widget.chatRoomDocId, Message.fromTextMessage(message));
    // setState(() {
    //   _messages.insert(0, message);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ChatCubit>.value(
        value: getIt<ChatCubit>()..getChatMessages(widget.chatRoomDocId),
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            state.map(
              initial: (value) {},
              loading: (value) {
                // if (!context.loaderOverlay.visible) {
                //   context.loaderOverlay.show();
                // }
              },
              error: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.appException.message),
                ));
              },
              chatCreated: (value) {},
              chatRoomsFetched: (_) {},
              chatMessagesFetched: (_) {},
            );
          },
          builder: (context, state) {
            if (state is ChatMessagesFetched) {
              return flutterchat.Chat(
                messages: state.chatMessages,
                onSendPressed: _handleSendPressed,
                user: types.User(id: FirebaseAuth.instance.currentUser!.uid),
              );
            } else {
              return Center(
                child: NativeMediumTitleText('No messages yet'),
              );
            }
          },
        ),
      ),
    );

    // return CommonScaffoldWithPadding(
    //   'Chats',
    //   content,
    //   // trailing: trailing,
    // );
  }
}
