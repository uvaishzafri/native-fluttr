import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as flutterchat;
import 'package:native/feature/chat/cubit/chat_messages_cubit.dart';
import 'package:native/feature/chat/report_user_bottom_sheet.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_simple_button.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_large_title_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:native/widget/text/native_small_body_text.dart';

@RoutePage()
class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen(
      {super.key, required this.chatRoomDocId, required this.name, required this.imageUrl, required this.userId});
  final String chatRoomDocId;
  final String name;
  final String imageUrl;
  final String userId;

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  // List<Chat> _chats = [];
  TextEditingController? _otherReasonTextController;
  // static DateFormat simpleTimeFormat = DateFormat('hh:mm a');
  // String? _selectedProblem;

  @override
  void initState() {
    super.initState();
    _otherReasonTextController = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final chatCubit = BlocProvider<ChatCubit>.value(value: getIt<ChatCubit>());
    //   chatCubit.getChatMessages(widget.chatRoomDocId);
    // });
  }

  @override
  void dispose() {
    _otherReasonTextController?.dispose();
    super.dispose();
  }

  void _handleSendPressed(types.PartialText message, ChatMessagesCubit chatMessageCubit) {
    final textMessage = types.TextMessage(
      author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: '',
      text: message.text,
    );

    _addMessage(textMessage, chatMessageCubit);
  }

  void _addMessage(types.TextMessage message, ChatMessagesCubit chatMessagesCubit) {
    // final chatCubit = context.read<ChatCubit>();
    // final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatMessagesCubit.createChatMessage(widget.chatRoomDocId, Message.fromTextMessage(message));
    // setState(() {
    //   _messages.insert(0, message);
    // });
  }

  @override
  Widget build(BuildContext context) {


    Widget content = BlocProvider<ChatMessagesCubit>.value(
      value: getIt<ChatMessagesCubit>()..getChatMessages(widget.chatRoomDocId),
      child: BlocConsumer<ChatMessagesCubit, ChatMessagesState>(
          listener: (context, state) {
            state.map(
              initial: (value) {},
              loading: (value) {
                // if (!context.loaderOverlay.visible) {
                //   context.loaderOverlay.show();
                // }
              },
            errorState: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.appException.message),
                ));
              },
            chatMessagesFetched: (_) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
            },
            );
          },
          builder: (context, state) {
            if (state is ChatMessagesFetched) {
            final chatMessageCubit = BlocProvider.of<ChatMessagesCubit>(context);
            // return _renderMessageList();
              return flutterchat.Chat(
                
              showUserAvatars: true,
              inputOptions: const flutterchat.InputOptions(
                sendButtonVisibilityMode: flutterchat.SendButtonVisibilityMode.always,
              ),
              dateIsUtc: true,
              dateHeaderBuilder: (p0) {
                return Center(
                  child: Container(
                    // alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorUtils.aquaGreen,
                    ),
                    child: NativeSmallBodyText(
                      // timeago.format(p0.dateTime),
                      p0.text,
                      color: ColorUtils.white,
                      // height: 22 / 12,
                    ),
                  ),
                );
              },
              theme: flutterchat.DefaultChatTheme(
                primaryColor: ColorUtils.purple.withOpacity(0.5),
                secondaryColor: ColorUtils.textLightGrey.withOpacity(0.1),
                messageBorderRadius: 4,
                inputBorderRadius: BorderRadius.circular(4),
                inputTextColor: Colors.black,
                inputBackgroundColor: ColorUtils.textLightGrey.withOpacity(0.1),
                sendButtonIcon: Container(
                  decoration: const BoxDecoration(
                    color: ColorUtils.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    color: ColorUtils.white,
                  ),
                ),
                inputMargin: const EdgeInsets.all(12),
                sentMessageBodyTextStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  color: ColorUtils.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 22 / 14,
                ),
                // receivedMessageBodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
                receivedMessageBodyTextStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  color: ColorUtils.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 22 / 14,
                ),
              ),
              // bubbleBuilder: bubbleBuilder,
              // bubbleBuilder: (child, {message = types.CustomMessage(), nextMessageInGroup = true}) {
              //   return child;
              // },

              avatarBuilder: (userId) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
                  ),
                );
              },
                messages: state.chatMessages,
              onSendPressed: (message) {
                _handleSendPressed(message, chatMessageCubit);
              },
                user: types.User(id: FirebaseAuth.instance.currentUser!.uid),
              );
            } else {
            return const Center(
                child: NativeMediumTitleText('No messages yet'),
              );
            }
          },
      ),
    );

    return SafeArea(
      child: Theme(
        data: ThemeData(
          cupertinoOverrideTheme: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              navActionTextStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorUtils.aquaGreen,
            appBar: AppBar(
              backgroundColor: ColorUtils.aquaGreen,
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 100,
              leading: IconButton(onPressed: () => context.router.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
                  ),
                  const SizedBox(width: 6),
                  NativeLargeTitleText(
                    widget.name,
                    color: ColorUtils.white,
                  ),
                ],
              ),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'block') {
                      showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => blockDialog(),
                      );
                    } else if (value == 'report') {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => ReportUserBottomSheet(userId: widget.userId),
                      );
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'block',
                        child: Row(
                          children: [
                            Icon(
                              Icons.block,
                              color: ColorUtils.textGrey,
                            ),
                            NativeLargeBodyText('Block'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'report',
                        child: Row(
                          children: [
                            Icon(
                              Icons.report_outlined,
                              color: Colors.red,
                            ),
                            NativeLargeBodyText(
                              'report',
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: ColorUtils.white,
                  ),
                ),
              ],
            ),
            // appBar: CupertinoNavigationBar(
            //   // padding: EdgeInsetsDirectional.only(top: 20),
            //   border: const Border(),
            //   backgroundColor: ColorUtils.aquaGreen,
            //   middle: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 4),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         CircleAvatar(
            //           backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
            //         ),
            //         const SizedBox(width: 6),
            //         NativeLargeTitleText(
            //           widget.name,
            //           color: ColorUtils.white,
            //         ),
            //       ],
            //     ),
            //   ),
            //   trailing:               PopupMenuButton(
            //     onSelected: (value) {},
            //     itemBuilder: (context) {
            //       return [
            //         const PopupMenuItem(
            //           value: 'block',
            //           child: Row(
            //             children: [
            //               Icon(
            //                 Icons.block,
            //                 color: ColorUtils.textGrey,
            //               ),
            //               NativeLargeBodyText('Block'),
            //             ],
            //           ),
            //         ),
            //         const PopupMenuItem(
            //           value: 'report',
            //           child: Row(
            //             children: [
            //               Icon(
            //                 Icons.report_outlined,
            //                 color: Colors.red,
            //               ),
            //               NativeLargeBodyText(
            //                 'report',
            //                 color: Colors.red,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ];
            //     },
            //     icon: const Icon(
            //       Icons.more_vert_rounded,
            //       color: ColorUtils.white,
            //     ),
            //   ),
            // ),
            body: Column(
              children: [
                // const SizedBox(height: 40),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorUtils.white,
                      // borderRadius: BorderRadius.vertical(
                      //   top: Radius.circular(20),
                      // ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 32, right: 32),
                      child: content,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget blockDialog() {
    return AlertDialog(
      backgroundColor: ColorUtils.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: NativeMediumTitleText('Are you sure?')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You will not be able to send or receive messages once blocked.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorUtils.black.withOpacity(0.6),
            ),
          ),
          // NativeMediumBodyText(
          //   'You will not be able to change this later.',
          //   color: ColorUtils.black.withOpacity(0.6),
          // ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: NativeSimpleButton(
                isEnabled: true,
                onPressed: () => context.router.pop(),
                fontSize: 14,
                text: 'Cancel',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: NativeButton(
                isEnabled: true,
                text: 'Yes, Block',
                fontSize: 14,
                onPressed: () {
                  // final user = User(
                  //   customClaims: CustomClaims(
                  //     birthday: DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  //     // birthday: _selectedDate!.toIso8601String(),
                  //   ),
                  // );
                  // profileCubit.updateProfile(user);
                },
              ),
            ),
          ],
        )
      ],
    );
  }


}
