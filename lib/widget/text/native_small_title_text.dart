import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 14pt fontweight - 500 height - 20pt
class NativeSmallTitleText extends StatelessWidget {
  /// fontsize - 14pt fontweight - 500 height - 20pt
  const NativeSmallTitleText(this.text, {super.key, this.color, this.fontWeight, this.height});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: color ?? ColorUtils.textGrey,
            // fontFamily: 'poppins',
            fontWeight: fontWeight,
            height: height,
          ),
    );
  }
}
