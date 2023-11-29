import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/home/native_card_details_screen.dart';
import 'package:native/model/user.dart';
import 'package:native/theme/theme.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Due to the page transition animation,
      // add a little delay to avoid the system ui update before seeing the next page
      Future.delayed(const Duration(milliseconds: 200), () async {
        updateSystemUi(context, Theme.of(context).primaryColor,
            Theme.of(context).primaryColor);
      });
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // body: NativeCardDetailsScreen(
      //   user: user,
      //   isDemoUser: isDemoUser,
      //   showBackButton: showBackButton,
      // ),
      body: Stack(
        children: [
          NativeCardDetailsScreen(
            user: user,
            isDemoUser: isDemoUser,
            showBackButton: showBackButton,
          ),
          if (overlayItem != null)
            Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: overlayItem!),
          if (showNext)
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: NativeButton(
                  isEnabled: true,
                  text: 'Next',
                  onPressed: () => context.router
                      .push(const HowToChoosePartnerLoaderRoute()),
                ),
              ),
            )
        ],
      ),
    );
  }
}
