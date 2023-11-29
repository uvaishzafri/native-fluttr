import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/util/string_ext.dart';

import '../../../../../../util/fav_card/fav_card_constants.dart';
import '../../../models/fav_card_category_model.dart';
import '../../../models/fav_card_items/fav_card_items.dart';
import 'category_list_expanded.dart';

class FavCardItemDetailCategoryList extends StatelessWidget {
  final FavCardItemModel item;

  const FavCardItemDetailCategoryList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [];
    for (int i = 0; i < min(3, item.categories.length); i++) {
      FavCardCategoryEnum favCardCategoryEnum =
          getFavCardCategoryEnum(cardCategory: item.categories[i]);
      FavCardCategoryModel favCardCategoryModel =
          getFavCardCategoryFromEnum(favCardCategoryEnum: favCardCategoryEnum);
      var widget = Row(
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
          const SizedBox(width: 7)
        ],
      );
      categories.add(widget);
    }
    if (item.categories.length > 3) {
      Widget widget = Text(
        "(+${item.categories.length - 3})",
        style: GoogleFonts.poppins().copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFBE94C6)),
      );
      categories.add(widget);
    }
    return GestureDetector(
      onTap: () => _showDetailPopUp(context),
      child: Row(
        children: categories,
      ),
    );
  }

  _showDetailPopUp(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${item.name}\'s Profile',
                            style: GoogleFonts.poppins().copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ))),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close))
                ],
              ),
              content: FavCardItemDetailCategoryListExpanded(item: item),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ));
  }
}
