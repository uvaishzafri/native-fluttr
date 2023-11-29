import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';

import '../../../i18n/translations.g.dart';
import 'native_card_expansion_tile.dart';

class MyFavCardTrends extends StatelessWidget {
  final Map<String, int> trends;

  const MyFavCardTrends({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    var trendsList = trends.entries.toList();
    return NativeCardExpansionTile(
      title: t.strings.favCardTrends,
      leadingImageAddress: "assets/native_card/trends.svg",
      expandedWidget: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: trendsList.length,
        itemBuilder: (BuildContext context, int index) {
          String message = trendsList[index].key.capitalize;
          int percentage = trendsList[index].value;
          FavCardCategoryEnum favCardCategoryEnum =
              getFavCardCategoryEnum(cardCategory: message);
          Color favCardColor =
              getFavCardColorFromEnum(favCardCategoryEnum: favCardCategoryEnum);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  message,
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 220,
                height: 15,
                child: LinearProgressIndicator(
                  backgroundColor: const Color(0xFFD9D9D9),
                  color: favCardColor,
                  minHeight: 15,
                  value: percentage * 0.01,
                ),
              ),
              Text(
                "$percentage%",
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
}
