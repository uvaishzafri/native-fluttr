import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/home/native_card_details_screen.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';

@RoutePage()
class NativeCardScaffold extends StatelessWidget {
  const NativeCardScaffold(
      {super.key, required this.user, this.overlayItem, this.isDemoUser = false, this.showBackButton = false});
  final User user;
  final Widget? overlayItem;
  final bool isDemoUser;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          NativeCardDetailsScreen(
            user: user,
            isDemoUser: isDemoUser,
            showBackButton: showBackButton,
          ),
          if (overlayItem != null) overlayItem!,
        ],
      ),
    );
  }
}
