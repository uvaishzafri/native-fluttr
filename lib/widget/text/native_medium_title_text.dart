import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 16pt fontweight - 500 height - 24pt
class NativeMediumTitleText extends StatelessWidget {
  /// fontsize - 16pt fontweight - 500 height - 24pt
  const NativeMediumTitleText(this.text, {super.key, this.color, this.fontWeight, this.height, this.fontSize});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: color ?? ColorUtils.textGrey,
            // fontFamily: 'poppins',
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ),
    );
  }
}
