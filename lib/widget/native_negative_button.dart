import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/widget/text/gradient_text.dart';

class NativeNegativeButton extends StatelessWidget {
  final bool isEnabled;
  final String text;
  final Function()? onPressed;
  final double? fontSize;

  const NativeNegativeButton({super.key, required this.isEnabled, required this.text, this.onPressed, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xB2BE94C6), Color(0xB27BC6CC)]),
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 54.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
              boxShadow: [
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
              onPressed: onPressed,
              child: GradientText(
                text,
                style: GoogleFonts.poppins().copyWith(fontSize: fontSize ?? 18, fontWeight: FontWeight.w600, color: Colors.black),
                gradient: const LinearGradient(colors: [Color(0xB2BE94C6), Color(0xB27BC6CC)]),
              ),
            ),
          ),
        ));
  }
}
