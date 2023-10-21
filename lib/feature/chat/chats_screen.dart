import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:native/model/chat_room.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_large_title_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:timeago/timeago.dart' as timeago;

@RoutePage()
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatRoom> _chats = [];
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyChatWidget() {
      return Column(
        children: [
          const SizedBox(height: 80),
          SvgPicture.asset('assets/chat/empty_chat.svg'),
          const SizedBox(height: 40),
          const NativeLargeTitleText(
            'There is no talk yet',
            fontWeight: FontWeight.w500,
          ),
          NativeLargeBodyText(
            'If you want to start falling in love, start with a chat',
            textAlign: TextAlign.center,
            height: 30 / 16,
            color: ColorUtils.black.withOpacity(0.6),
          ),
          const SizedBox(height: 30),
          NativeButton(
            isEnabled: true,
            text: 'Find your partner',
            onPressed: () {
              // context.router.push(const );
            },
          ),
          const SizedBox(height: 30),
        ],
      );
    }

    Widget searchBar() {
      return NativeTextField(_searchController, hintText: 'Search', prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)));
    }

    Widget content = BlocProvider<ChatCubit>.value(
      value: getIt<ChatCubit>(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          state.map(
            initial: (value) {},
            loading: (value) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            },
            error: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.appException.message),
              ));
            },
            // chatCreated: (value) {},
            chatRoomsFetched: (_) {},
            // chatMessagesFetched: (_) {},
            // chatMessageCreated: (value) {},
          );
        },
        builder: (context, state) {
          // final chatCubit = BlocProvider.of<ChatCubit>(context);
          if (state is ChatRoomFetched) {
            _chats = state.chatRooms;
            return _chats.isEmpty
                ? emptyChatWidget()
                : Column(
                    children: [
                      searchBar(),
                      const NativeMediumTitleText('Recent chats'),
                      Expanded(
                          child: ListView.builder(
                        itemCount: _chats.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.router.push(
                                ChatMessagesRoute(
                                  chatRoomDocId: _chats[index].firestoreDocId!,
                                  userId: _chats[index]
                                      .participants
                                      .keys
                                      .firstWhere((element) => element != FirebaseAuth.instance.currentUser?.uid),
                                  name: _chats[index].participants[_chats[index].participants.keys.firstWhere((element) => element != FirebaseAuth.instance.currentUser?.uid)]![0],
                                  imageUrl: _chats[index].participants[_chats[index].participants.keys.firstWhere((element) => element != FirebaseAuth.instance.currentUser?.uid)]![1],
                                ),
                              );
                            },
                            contentPadding: const EdgeInsets.only(right: 10),
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(_chats[index].participants[_chats[index].participants.keys.firstWhere((element) => element != FirebaseAuth.instance.currentUser?.uid)]![1]),
                            ),
                            title: NativeMediumTitleText(_chats[index].participants[_chats[index].participants.keys.firstWhere((element) => element != FirebaseAuth.instance.currentUser?.uid)]![0]),
                            subtitle: Row(
                              children: [
                                NativeMediumBodyText(_chats[index].lastMessage ?? "No conversation yet"),
                                const Spacer(),
                                _chats[index].lastMessageTime != null
                                    ? NativeMediumBodyText(timeago.format(_chats[index].lastMessageTime!))
                                    : Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(color: ColorUtils.purple, borderRadius: BorderRadius.circular(20)),
                                        child: const NativeSmallBodyText(
                                          'Start now',
                                          color: ColorUtils.white,
                                          fontSize: 10,
                                          height: 14 / 10,
                                        ),
                                      ),
                              ],
                            ),
                          );
                        },
                      )),
                    ],
                  );
          } else {
            return emptyChatWidget();
          }
        },
      ),
    );

    // Widget trailing = IconButton(
    //   onPressed: () {
    //     context.router.pop();
    //   },
    //   icon: const Icon(Icons.close_outlined),
    // );

    return CommonScaffoldWithPadding(
      'Chats',
      content,
      // trailing: trailing,
    );
  }
}
