import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:native/feature/likes/cubit/likes_cubit.dart';

const TYPE = "type";
const ARGS = "args";

@lazySingleton
class NotificationNavigator {
  void navigateNotification({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) {
    _parse(context, data);
  }

  void _parse(BuildContext context, Map<String, dynamic> data) {
    String? type = data[TYPE];

    switch (type) {
      case 'LIKED':
        final likesBloc = getIt<LikesCubit>();
        likesBloc.fetchLikesReport();
        context.router.push(HomeWrapperRoute(children: [LikesRoute()]));
        break;
      case 'CHAT':
        final chatBloc = getIt<ChatCubit>();
        chatBloc.getChatRooms();
        context.router.push(HomeWrapperRoute(children: [ChatsRoute()]));
        break;
      default:
    }
  }
}
