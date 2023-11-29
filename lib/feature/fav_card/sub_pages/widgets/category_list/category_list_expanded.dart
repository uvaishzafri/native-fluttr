import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/util/string_ext.dart';

import '../../../../../../util/fav_card/fav_card_constants.dart';
import '../../../models/fav_card_category_model.dart';
import '../../../models/fav_card_items/fav_card_items.dart';

class FavCardItemDetailCategoryListExpanded extends StatelessWidget {
  final FavCardItemModel item;

  const FavCardItemDetailCategoryListExpanded({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [];
    for (int i = 0; i < item.categories.length; i++) {
      FavCardCategoryEnum favCardCategoryEnum =
          getFavCardCategoryEnum(cardCategory: item.categories[i]);
      FavCardCategoryModel favCardCategoryModel =
          getFavCardCategoryFromEnum(favCardCategoryEnum: favCardCategoryEnum);
      Widget widget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            favCardCategoryModel.imageAddress,
            width: 14,
            height: 14,
            color: favCardCategoryModel.color,
          ),
          const SizedBox(width: 3),
          Text(
            favCardCategoryModel.name.name.capitalize(),
            style: GoogleFonts.poppins().copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: favCardCategoryModel.color),
          ),
          const SizedBox(width: 16)
        ],
      );
      categories.add(widget);
    }
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 8,
      children: categories,
    );
  }
}
