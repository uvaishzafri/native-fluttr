import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

class NativeSimpleButton extends StatelessWidget {
  const NativeSimpleButton(
      {super.key,
      required this.isEnabled,
      required this.text,
      this.onPressed,
      this.fontSize,
      this.fontWeight});
  final bool isEnabled;
  final String text;
  final Function()? onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorUtils.textLightGrey.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19616161),
            offset: Offset(10, 10),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: !isEnabled ? null : onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xffffffff),
            fontSize: fontSize ?? 18,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
