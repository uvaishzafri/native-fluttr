import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/i18n/translations.g.dart';

class NativePlusPromotion extends StatelessWidget {
  const NativePlusPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/search/native_plus.svg",
                width: 20,
                height: 20,
                color: const Color(0xFFBE94C6),
              ),
              const SizedBox(
                width: 13,
              ),
              Text(
                t.strings.nativePlus,
                style: GoogleFonts.poppins().copyWith(color: const Color(0xFFBE94C6), fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Text(
            t.strings.upgradeNow,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
              height: 22 / 8,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFFBE94C6),
              decorationThickness: 2,
              color: const Color(0xFFBE94C6),
              shadows: [const Shadow(color: Colors.white, offset: Offset(0, -5))],
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      Text(
        t.strings.nativePlusPromotionBody,
        style: GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF7BC6CC)),
      ),
      const SizedBox(height: 30),
    ]);
  }
}
