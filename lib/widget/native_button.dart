import 'package:flutter/material.dart';

class NativeButton extends StatelessWidget {
  const NativeButton(
      {super.key,
      required this.isEnabled,
      required this.text,
      this.onPressed,
      this.fontSize});
  final bool isEnabled;
  final String text;
  final Function()? onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19616161),
              offset: Offset(10, 10),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              isEnabled ? const Color(0xB2BE94C6) : const Color(0x55BE94C6),
              isEnabled ? const Color(0xB2BE94C6) : const Color(0x55BE94C6),
              isEnabled ? const Color(0xB27BC6CC) : const Color(0x557BC6CC),
            ],
          )),
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
