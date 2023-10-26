import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/widget/text/native_small_title_text.dart';

class MultiMatchDialog extends StatefulWidget {
  const MultiMatchDialog({super.key, required this.matchedUsers, required this.selfPhotoUrl});

  final List<User> matchedUsers;
  final String selfPhotoUrl;

  @override
  State<MultiMatchDialog> createState() => _MultiMatchDialogState();
}

class _MultiMatchDialogState extends State<MultiMatchDialog> {
  List<List<double>> circles = [];

  bool checkCollision(double left, double top) {
    // Check for collision with existing circles
    for (var circle in circles) {
      double distance = sqrt(
        pow(left - circle[0], 2) + pow(top - circle[1], 2),
      );

      if (distance < 2 * 20) {
        return true; // Collision detected
      }
    }

    // Add the new circle's position
    circles.add([left, top]);

    return false; // No collision
  }

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
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: CachedNetworkImageProvider(widget.selfPhotoUrl),
                ),
              ),
              ...widget.matchedUsers.map((e) {
                double left, top;

                do {
                  // Generate random positions
                  left = Random().nextDouble() * (330 - 2 * 20);
                  top = Random().nextDouble() * (300 - 2 * 20);
                } while (checkCollision(left, top));

                return Positioned(
                  left: left,
                  top: top,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(e.photoURL ?? ''),
                      ),
                      const SizedBox(height: 4),
                      NativeSmallBodyText(
                        e.displayName!,
                        color: ColorUtils.white,
                      )
                    ],
                  ),
                );
              }).toList(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         CircleAvatar(
              //           radius: 36,
              //           backgroundImage: CachedNetworkImageProvider(widget.selfPhotoUrl),
              //         ),
              //         const SizedBox(height: 4),
              //         const NativeSmallTitleText(
              //           'You',
              //           color: ColorUtils.white,
              //         )
              //       ],
              //     ),
              //     const SizedBox(width: 24),
              //     const Icon(
              //       CupertinoIcons.heart_fill,
              //       color: ColorUtils.purple,
              //       size: 37,
              //     ),
              //     const SizedBox(width: 24),
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           radius: 36,
              //           backgroundImage: CachedNetworkImageProvider(matchedUserPhotoUrl),
              //         ),
              //         const SizedBox(height: 4),
              //         NativeSmallTitleText(
              //           userName,
              //           color: ColorUtils.white,
              //         )
              //       ],
              //     ),
              //   ],
              // )
            ],
          ),
          const SizedBox(height: 16),
          NativeSmallTitleText('You have matched with ${widget.matchedUsers.length} people'),
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
