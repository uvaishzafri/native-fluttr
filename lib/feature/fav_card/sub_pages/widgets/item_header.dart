import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../i18n/translations.g.dart';
import '../../../app/app_router.gr.dart';
import '../../models/fav_card_items/fav_card_items.dart';
import 'category_list/category_list.dart';

class ItemHeader extends StatelessWidget {
  final FavCardItemModel item;
  final bool clickAble;
  final int noOfLikedCards;

  const ItemHeader(
      {super.key,
      required this.item,
      required this.clickAble,
      required this.noOfLikedCards});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (clickAble)
          context.router.push(
              ItemDetailRoute(item: item, noOfLikedFavCards: noOfLikedCards)),
      },
      child: Row(
        children: [
          Hero(
            tag: item.id,
            child: Container(
              width: 100,
              height: 90,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: Image.network(item.imageAddress).image,
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 19),
              FavCardItemDetailCategoryList(item: item),
              const SizedBox(height: 6),
              //TODO: need to implement strings translating functions
              Text(
                "${item.likes.toString()} ${t.strings.peopleLike}",
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
