import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 22pt fontweight - 400
class NativeLargeTitleText extends StatelessWidget {
  const NativeLargeTitleText(this.text, {super.key, this.color, this.fontWeight});
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: color ?? ColorUtils.textGrey,
            fontWeight: fontWeight,
          ),
    );
  }
}
