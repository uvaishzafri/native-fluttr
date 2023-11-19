import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';
import 'package:native/util/string_ext.dart';

import '../../models/fav_card_category_model.dart';
import '../../models/fav_card_items/fav_card_items.dart';
import 'single_item.dart';

class SingleCategoryGrid extends StatelessWidget {
  final FavCardCategoryModel selectedCategory;
  final List<FavCardItemModel> items;
  final bool? restrictColumns;

  const SingleCategoryGrid({super.key, required this.selectedCategory, required this.items, this.restrictColumns});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          SvgPicture.asset(
            selectedCategory.imageAddress,
            width: 20,
            height: 20,
            color: selectedCategory.color,
          ),
          const SizedBox(width: 10),
          Text(
            selectedCategory.name.stringify().capitalize(),
            style: GoogleFonts.poppins().copyWith(
              color: const Color(0xFF1E1E1E),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              height: 22 / 8,
            ),
          ),
        ]),
        const SizedBox(height: 15),
        _getGridView()
      ],
    );
  }

  Widget _getGridView() {
    //Top Tab
    if (restrictColumns ?? false) {
      return SizedBox(
        height: 113,
        child: GridView.count(
          childAspectRatio: 1.38,
          physics: const ScrollPhysics(),
          crossAxisCount: 1,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          children: List.generate(items.length, (index) {
            return SingleItem(item: items[index]);
          }),
        ),
      );
    } else {
      return SizedBox(
        child: Expanded(
          child: GridView.count(
            childAspectRatio: 0.72,
            physics: const ScrollPhysics(),
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(items.length, (index) {
              return SingleItem(item: items[index]);
            }),
          ),
        ),
      );
    }
  }
}
