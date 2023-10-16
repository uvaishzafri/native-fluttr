import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

/// fontsize - 22pt fontweight - 400 height - 28pt
class NativeLargeTitleText extends StatelessWidget {

  /// fontsize - 22pt fontweight - 400 height - 28pt
  const NativeLargeTitleText(this.text, {super.key, this.color, this.fontWeight, this.height});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: color ?? ColorUtils.textGrey,
          // fontFamily: 'poppins',
            fontWeight: fontWeight,
          height: height
          ),
    );
  }
}
