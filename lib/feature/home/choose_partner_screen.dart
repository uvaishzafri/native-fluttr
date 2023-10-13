import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/model/native.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_card.dart';

@RoutePage()
class ChoosePartnerScreen extends StatelessWidget {
  const ChoosePartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    _recommendations()
                  ],
                )),
                // _recommendations(),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 100,
          //   left: 100,
          //   child: Icon(
          //     Icons.touch_app_outlined,
          //     size: 80,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _recommendations() {
    return SliverGrid.builder(
      // padding: const EdgeInsets.all(8),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var overlayItem = Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      // color: ColorUtils.textLightGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          // radius: 30,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          onPressed: () {},
                          child: const Icon(Icons.undo_rounded),
                        ),
                        const SizedBox(width: 48),
                        FloatingActionButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => likeDialog(context),
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: const Icon(
                            Icons.thumb_up_alt_outlined,
                            color: ColorUtils.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //     bottom: -30,
                //     right: 90,
                //     child: Icon(
                //       Icons.touch_app_outlined,
                //       size: 80,
                //     )),
              ],
            );
            context.router.push(NativeCardScaffold(nativeUser: usersList[index], overlayItem: overlayItem));
          },
          child: NativeUserCard(
            native: usersList[index],
          ),
        );
      },
    );
  }

  Widget likeDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorUtils.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: 'All you do is send a ',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: ColorUtils.textGrey,
                    height: 22 / 14,
                  ),
              children: [
                TextSpan(
                  text: 'LIKE',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorUtils.purple,
                        fontWeight: FontWeight.w700,
                        height: 22 / 14,
                      ),
                ),
                TextSpan(
                  text: ' to get matched',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorUtils.textGrey,
                        height: 22 / 14,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 330,
                height: 330,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              Container(
                width: 186,
                height: 186,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/home/ic_test.png'),
                  ),
                  SizedBox(width: 24),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: ColorUtils.purple,
                    size: 37,
                  ),
                  SizedBox(width: 24),
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/home/ic_profile_pic2.png'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      actions: [
        NativeButton(
          isEnabled: true,
          onPressed: () => context.router.pop(),
          text: "Let's go",
        )
      ],
    );
  }
}
