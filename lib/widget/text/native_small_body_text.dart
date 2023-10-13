import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 12pt fontweight - 400 height - 16pt
class NativeSmallBodyText extends StatelessWidget {
  /// fontsize - 12pt fontweight - 400 height - 16pt
  const NativeSmallBodyText(this.text, {super.key, this.color, this.fontWeight, this.height, this.fontSize});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: color ?? ColorUtils.textGrey,
            // fontFamily: 'poppins',
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
          ),
    );
  }
}
