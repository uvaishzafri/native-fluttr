import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../i18n/translations.g.dart';

class WhatFavCarsContracted extends StatelessWidget {
  const WhatFavCarsContracted({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, top: 10),
      child: SizedBox(
        height: 50,
        child: Stack(
          children: [
            Stack(children: [
              Stack(
                children: [
                  Image.asset("assets/fav_card/what_fav_card_background.png", fit: BoxFit.fill, width: double.infinity),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            t.strings.whatFavCardShort.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins()
                                .copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 2, height: 2),
                          ),
                          Text(
                            "${t.strings.learnMore} >>",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins().copyWith(
                              color: Colors.transparent,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                              height: 22 / 8,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 2,
                              shadows: [const Shadow(color: Colors.white, offset: Offset(0, -5))],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
