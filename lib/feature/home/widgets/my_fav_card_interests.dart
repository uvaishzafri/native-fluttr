import 'dart:math';

import 'package:flutter/material.dart';
import 'package:native/feature/home/widgets/native_card_expansion_tile.dart';

import '../../../i18n/translations.g.dart';
import '../../fav_card/models/fav_card_items/fav_card_items.dart';
import 'fav_card_interest_list_item.dart';

class MyFavCardInterests extends StatelessWidget {
  final List<FavCardItemModel> interests;

  const MyFavCardInterests({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return NativeCardExpansionTile(
      title: t.strings.favCardInterests,
      leadingImageAddress: "assets/native_card/interests.svg",
      expandedWidget: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        //TODO: Ideally we should not be hardcoding limits here, this needs to be removed once backend setup is complete
        itemCount: min(interests.length, 3),
        itemBuilder: (BuildContext context, int index) {
          return FavCardInterestListItem(
              item: interests[index], index: index + 1);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 32,
        ),
      ),
    );
  }
}
