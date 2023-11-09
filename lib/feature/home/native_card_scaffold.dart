import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/home/native_card_details_screen.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';

@RoutePage()
class NativeCardScaffold extends StatelessWidget {
  const NativeCardScaffold(
      {super.key,
      required this.user,
      this.overlayItem,
      this.isDemoUser = false,
      this.showBackButton = false,
      this.showNext = false});
  final User user;
  final Widget? overlayItem;
  final bool isDemoUser;
  final bool showBackButton;
  final bool showNext;

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
          if (showNext)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: NativeButton(
                isEnabled: true,
                text: 'Next',
                onPressed: () => context.router.push(const HowToChoosePartnerLoaderRoute()),
              ),
            ),
        ],
      ),
    );
  }
}
