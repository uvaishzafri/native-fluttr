import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 16pt fontweight - 400 height - 24pt
class NativeLargeBodyText extends StatelessWidget {
  /// fontsize - 16pt fontweight - 400 height - 24pt
  const NativeLargeBodyText(this.text, {super.key, this.color, this.fontWeight, this.height, this.textAlign});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color ?? ColorUtils.textGrey,
          // fontFamily: 'poppins',
            fontWeight: fontWeight,
          height: height
          ),
    );
  }
}
