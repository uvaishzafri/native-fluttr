import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 16pt fontweight - 400
class NativeLargeBodyText extends StatelessWidget {
  const NativeLargeBodyText(this.text, {super.key, this.color, this.fontWeight});
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color ?? ColorUtils.textGrey,
            fontWeight: fontWeight,
          ),
    );
  }
}
