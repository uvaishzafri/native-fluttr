import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../i18n/translations.g.dart';

class FavCardSearchEmptyState extends StatelessWidget {
  const FavCardSearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/fav_card/empty_search.svg",
            height: 200, width: 200),
        const SizedBox(height: 20),
        Text(t.strings.startSearchingFavCards,
            style: GoogleFonts.poppins()
                .copyWith(fontSize: 12, fontWeight: FontWeight.w400))
      ],
    );
  }
}
