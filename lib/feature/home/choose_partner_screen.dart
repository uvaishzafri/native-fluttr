import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/like_dialog.dart';
import 'package:native/widget/like_overlay.dart';
import 'package:native/widget/native_card.dart';

@RoutePage()
class ChoosePartnerScreen extends StatelessWidget {
  const ChoosePartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/home/ic_logo_black.svg',
                  ),
                  // Image.asset('assets/ic_logo_light.png'),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Choose a partner to view and ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorUtils.textGrey,
                            height: 30 / 16,
                          ),
                      children: [
                        TextSpan(
                          text: 'LIKE',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: ColorUtils.purple,
                                    height: 30 / 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      _recommendations(),
                    ],
                  )),
                  // _recommendations(),
                ],
              ),
            ),
            const Positioned(
              bottom: 100,
              left: 100,
              child: Icon(
                Icons.touch_app_outlined,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendations() {
    return SliverGrid.builder(
      // padding: const EdgeInsets.all(8),
      itemCount: usersList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        // childAspectRatio: 0.6,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var overlayItem = LikeOverlay(
              onPressedLike: () {
                showDialog(
                  context: context,
                  builder: (context) => const LikeDialog(),
                );
              },
              isTutorial: true,
            );
            context.router.push(NativeCardScaffold(
                user: usersList[index],
                overlayItem: overlayItem,
                isDemoUser: false));
          },
          child: NativeUserCard(
            native: usersList[index],
          ),
        );
      },
    );
  }
}
