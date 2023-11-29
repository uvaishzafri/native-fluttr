import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/app/app_router.gr.dart';
import '../util/color_utils.dart';
import 'native_button.dart';

class LikeDialog extends StatelessWidget {
  const LikeDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage:
                        AssetImage('assets/home/ic_profile_pic2.png'),
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
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('tutorialCompleted', true);
            if (context.mounted) {
              context.router.pop();
              context.router.replaceAll([const HomeWrapperRoute()]);
            }
          },
          text: "Let's go",
        )
      ],
    );
  }
}
