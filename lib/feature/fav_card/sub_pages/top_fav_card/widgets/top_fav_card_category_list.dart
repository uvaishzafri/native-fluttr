import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../util/fav_card/fav_card_constants.dart';
import '../../../models/fav_card_category_model.dart';
import '../../../models/fav_card_items/fav_card_items.dart';

class TopFavCardCategoryList extends StatelessWidget {
  final FavCardItemModel item;

  const TopFavCardCategoryList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [];
    for (int i = 0; i < item.categories.length; i++) {
      FavCardCategoryEnum favCardCategoryEnum =
          getFavCardCategoryEnum(cardCategory: item.categories[i]);
      FavCardCategoryModel favCardCategoryModel =
          getFavCardCategoryFromEnum(favCardCategoryEnum: favCardCategoryEnum);
      var widget = Row(
        children: [
          const SizedBox(width: 3),
          SvgPicture.asset(
            favCardCategoryModel.imageAddress,
            width: 17,
            height: 17,
            color: favCardCategoryModel.color,
          ),
        ],
      );
      categories.add(widget);
    }
    return Row(
      children: categories,
    );
  }
}
