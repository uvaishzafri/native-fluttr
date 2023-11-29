import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/fav_card/models/fav_card_items/fav_card_items.dart';

import '../../fav_card/sub_pages/top_fav_card/widgets/top_fav_card_category_list.dart';

class FavCardInterestListItem extends StatelessWidget {
  final FavCardItemModel item;
  final int index;

  const FavCardInterestListItem(
      {super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Text(
            "$index.",
            style: GoogleFonts.poppins().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFBE94C6)),
          ),
          const SizedBox(width: 8),
          Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: Image.network(item.imageAddress).image,
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.poppins()
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    TopFavCardCategoryList(item: item),
                  ],
                ),
                Text(item.comment ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7B7B7B)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
