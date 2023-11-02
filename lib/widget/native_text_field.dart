import 'package:flutter/material.dart';

class NativeTextField extends StatelessWidget {
  const NativeTextField(
    this.controller, {
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final Icon? prefixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => TextField(
        onTap: onTap,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.tertiaryContainer,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          hintText: hintText,
          prefixIcon: prefixIcon, //icon at head of input
          hintStyle: const TextStyle(color: Color(0x321E1E1E), fontSize: 14, fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(color: Color(0xff1E1E1E), fontSize: 14, fontWeight: FontWeight.w500),
        ),
      );
}
