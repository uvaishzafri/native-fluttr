import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

class SingleMatchDialog extends StatelessWidget {
  const SingleMatchDialog(
      {super.key, required this.userName, required this.matchedUserPhotoUrl, required this.selfPhotoUrl});

  final String userName;
  final String matchedUserPhotoUrl;
  final String selfPhotoUrl;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              RichText(
                text: TextSpan(
                  text: "It's a match",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorUtils.purple,
                        fontSize: 20,
                        height: 22 / 20,
                      ),
                ),
              ),
              IconButton(onPressed: () => context.router.pop(), icon: const Icon(Icons.close))
            ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: CachedNetworkImageProvider(selfPhotoUrl),
                      ),
                      const SizedBox(height: 4),
                      const NativeSmallTitleText(
                        'You',
                        color: ColorUtils.white,
                      )
                    ],
                  ),
                  const SizedBox(width: 24),
                  const Icon(
                    CupertinoIcons.heart_fill,
                    color: ColorUtils.purple,
                    size: 37,
                  ),
                  const SizedBox(width: 24),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: CachedNetworkImageProvider(matchedUserPhotoUrl),
                      ),
                      const SizedBox(height: 4),
                      NativeSmallTitleText(
                        userName,
                        color: ColorUtils.white,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          NativeSmallTitleText('You and $userName liked each other'),
        ],
      ),
      actions: [
        NativeButton(
          isEnabled: true,
          onPressed: () {
            Navigator.of(context).pop();
            context.navigateTo(const HomeWrapperRoute(children: [ChatsRoute()]));
          },
          text: "Chat",
        )
      ],
    );
  }
}
