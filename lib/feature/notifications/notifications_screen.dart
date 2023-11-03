import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/notifications/cubit/notification_cubit.dart';
import 'package:native/feature/notifications/filter_by_bottom_sheet.dart';
import 'package:native/model/app_notification.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:timeago/timeago.dart' as timeago;

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // List<ChatRoom> _chats = [];
  // TextEditingController? _searchController;
  bool isLikesSelected = true;
  bool isChatsSelected = true;

  @override
  void initState() {
    super.initState();
    // _searchController = TextEditingController();
    _fetchNotifications();
  }

  _fetchNotifications() {
    final notificationBloc = getIt<NotificationCubit>();
    notificationBloc.fetchNotifications();
  }

  @override
  void dispose() {
    // _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = BlocProvider<NotificationCubit>.value(
      value: getIt<NotificationCubit>(), //..fetchNotifications(),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          state.map(
            initial: (value) {},
            loading: (value) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            },
            errorState: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              if (value.appException is UnauthorizedException) {
                BlocProvider.of<AppCubit>(context).logout();
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.appException.message),
              ));
            },
            successState: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
            },
          );
        },
        builder: (context, state) {
          if (state is SuccessState) {
            List<AppNotification> notificationList = [];
            if (!isChatsSelected && !isLikesSelected) {
              notificationList = state.notifications;
            } else if (isChatsSelected && isLikesSelected) {
              notificationList = state.notifications
                  .where(
                      (element) => element.type == NotificationType.liked || element.type == NotificationType.matched)
                  .toList();
            } else if (isChatsSelected) {
              notificationList =
                  state.notifications.where((element) => element.type == NotificationType.matched).toList();
            } else if (isLikesSelected) {
              notificationList =
                  state.notifications.where((element) => element.type == NotificationType.liked).toList();
            }

            return Column(
              children: [
                // CupertinoSlidingSegmentedControl(
                //   children: {
                //     'From you': Text('From you'),
                //     'From others': Text('From others'),
                //   },
                //   onValueChanged: (value) {},
                // ),
                const SizedBox(height: 12),
                Expanded(
                  child: GroupedListView<AppNotification, DateTime>(
                    elements: notificationList,
                    // elements: [
                    //   usersList[0],
                    //   usersList[1],
                    //   usersList[2]
                    // ],
                    order: GroupedListOrder.DESC,
                    groupBy: groupLikeList,
                    // groupBy: (element) => element.timestamp!,
                    // groupBy: (element) => likes.fromYou.firstWhere((ele) => element.uid == ele.userId).likedDate,
                    groupSeparatorBuilder: (value) => NativeMediumTitleText(groupHeaderText(value)),
                    // groupSeparatorBuilder: (value) => NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                    itemBuilder: (context, element) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        // backgroundImage: AssetImage(element.imageUrl),
                        backgroundImage: CachedNetworkImageProvider(element.user?.photoURL! ?? ''),
                      ),
                      title: Row(
                        children: [
                          NativeSmallBodyText(
                            element.user?.displayName ?? '',
                            fontWeight: FontWeight.w500,
                            height: 22 / 12,
                          ),
                          const Spacer(),
                          NativeSmallBodyText(
                            timeago.format(element.timestamp!),
                            height: 22 / 12,
                          )
                        ],
                      ),
                      subtitle: NativeSmallBodyText(
                        element.type == NotificationType.liked
                            ? 'Liked your profile'
                            : element.type == NotificationType.blocked
                                ? "Blocked you"
                                : element.type == NotificationType.matched
                                    ? "Profile matched"
                                    : "Requested chat",
                        height: 22 / 12,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox.expand();
          }
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

  DateTime groupLikeList(AppNotification element) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime thisWeek = today.subtract(Duration(days: today.weekday));

    DateTime lastWeek = thisWeek.subtract(const Duration(days: 7));
    DateTime thisMonth = DateTime(today.year, today.month, 1);
    DateTime lastMonth = DateTime(today.year, today.month - 1, 1);
    return element.timestamp!.isAfter(today)
        ? today
        : element.timestamp!.isAfter(yesterday)
            ? yesterday
            : element.timestamp!.isAfter(thisWeek)
                ? thisWeek
                : element.timestamp!.isAfter(lastWeek)
                    ? lastWeek
                    : element.timestamp!.isAfter(thisMonth)
                        ? thisMonth
                        : element.timestamp!.isAfter(lastMonth)
                            ? lastMonth
                            : DateTime(1900);
  }

  String groupHeaderText(DateTime dateTime) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime thisWeek = today.subtract(Duration(days: today.weekday));

    DateTime lastWeek = thisWeek.subtract(const Duration(days: 7));
    DateTime thisMonth = DateTime(today.year, today.month, 1);
    DateTime lastMonth = DateTime(today.year, today.month - 1, 1);
    return dateTime == today
        ? 'Today'
        : dateTime == yesterday
            ? 'Yesterday'
            : dateTime == thisWeek
                ? 'This Week'
                : dateTime == lastWeek
                    ? 'Last Week'
                    : dateTime == thisMonth
                        ? 'This Month'
                        : dateTime == lastMonth
                            ? 'Last Month'
                            : 'Earlier';
  }
}
