import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../i18n/translations.g.dart';
import '../../../widget/text/native_medium_title_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Stack(
        children: [
          Align(alignment: Alignment.center, child: NativeMediumTitleText(t.strings.myFavCard)),
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "assets/fav_card/top_fav_card.svg",
              height: 20,
              width: 20,
            ),
          )
        ],
      ),
    );
  }
}
