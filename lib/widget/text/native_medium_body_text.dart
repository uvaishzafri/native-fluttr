import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 14pt fontweight - 400 height - 20pt
class NativeMediumBodyText extends StatelessWidget {
  /// fontsize - 14pt fontweight - 400 height - 20pt
  const NativeMediumBodyText(this.text, {super.key, this.color, this.fontWeight, this.height, this.letterSpacing});
  
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color ?? ColorUtils.textGrey,
            fontWeight: fontWeight,
            height: height,
            letterSpacing: letterSpacing,
          ),
    );
  }
}
