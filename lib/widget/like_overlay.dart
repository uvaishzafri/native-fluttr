import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

class LikeOverlay extends StatelessWidget {
  const LikeOverlay({super.key, required this.onPressedLike, this.isTutorial = false});
  final VoidCallback onPressedLike;
  final bool isTutorial;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  onPressed: () {
                    context.router.pop();
                  },
                  child: const Icon(Icons.undo_rounded),
                ),
                const SizedBox(width: 48),
                FloatingActionButton(
                  onPressed: onPressedLike,
                  // onPressed: () => showDialog(
                  //   context: context,
                  //   builder: (context) => likeDialog(context /*chatCubit*/),
                  // ),
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
        if (isTutorial)
          const Positioned(
              bottom: -30,
              right: 90,
              child: Icon(
                Icons.touch_app_outlined,
                size: 80,
              )),
      ],
    );
  }
}