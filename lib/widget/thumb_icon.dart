import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';

class ThumbIcon extends StatelessWidget {
  final TextEditingController controller;

  const ThumbIcon({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: OverflowBox(
        maxWidth: 150,
        child: TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(color: ColorUtils.purple),
          decoration: const InputDecoration(
              fillColor: Colors.transparent,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              border: InputBorder.none,
              isDense: true),
          controller: controller,
        ),
      ),
    );
  }
}
