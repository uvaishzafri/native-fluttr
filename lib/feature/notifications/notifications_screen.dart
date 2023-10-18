import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:native/feature/notifications/filter_by_bottom_sheet.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/util/datetime_extension.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // List<ChatRoom> _chats = [];
  // TextEditingController? _searchController;
  bool isLikesSelected = false;
  bool isChatsSelected = false;

  @override
  void initState() {
    super.initState();
    // _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            chatCreated: (value) {},
            chatRoomsFetched: (_) {},
            chatMessagesFetched: (_) {},
          );
        },
        builder: (context, state) {
          // final chatCubit = BlocProvider.of<ChatCubit>(context);
          return Column(
            children: [
              // CupertinoSlidingSegmentedControl(
              //   children: {
              //     'From you': Text('From you'),
              //     'From others': Text('From others'),
              //   },
              //   onValueChanged: (value) {},
              // ),
              SizedBox(height: 12),
              Expanded(
                child: GroupedListView<User, DateTime>(
                  elements: [
                    usersList[0],
                    usersList[1],
                    usersList[2]
                  ],
                  groupBy: (element) => likes.fromYou.firstWhere((ele) => element.uid == ele.userId).likedDate,
                  groupSeparatorBuilder: (value) => Text(DateFormat('dd-MMM-yyyy').format(value)),
                  itemBuilder: (context, element) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      // backgroundImage: AssetImage(element.imageUrl),
                      backgroundImage: CachedNetworkImageProvider(element.photoURL!),
                    ),
                    title: Row(
                      children: [
                        NativeSmallBodyText(
                          '${element.displayName}, ${DateTime.tryParse(element.customClaims!.birthday!)?.ageFromDate()}',
                          fontWeight: FontWeight.w500,
                          height: 22 / 12,
                        ),
                        Spacer(),
                        NativeSmallBodyText(
                          '2hrs',
                          height: 22 / 12,
                        )
                      ],
                    ),
                    subtitle: NativeSmallBodyText(
                      'Liked your profile',
                      height: 22 / 12,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    Widget trailing = IconButton(
      onPressed: () {
        // context.router.pop();
        showModalBottomSheet(
          context: context,
          builder: (context) => FilterByBottomSheet(
            isLikesSelected: isLikesSelected,
            isChatsSelected: isChatsSelected,
            onSubmit: onSubmit,
          ),
        );
      },
      icon: const Icon(
        Icons.filter_list_rounded,
        color: ColorUtils.white,
      ),
    );

    return CommonScaffoldWithPadding(
      'Notifications',
      content,
      trailing: trailing,
    );
  }

  void onSubmit(isLikes, isChats) {
    isLikesSelected = isLikes;
    isChatsSelected = isChats;
    setState(() {});
  }
}
