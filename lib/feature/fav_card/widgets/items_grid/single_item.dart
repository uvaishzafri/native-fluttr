import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/app/app_router.gr.dart';

import '../../models/fav_card_items/fav_card_items.dart';

class SingleItem extends StatelessWidget {
  final FavCardItemModel item;
  final int noOfLikedFavCards;

  const SingleItem(
      {super.key, required this.item, required this.noOfLikedFavCards});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
          ItemDetailRoute(item: item, noOfLikedFavCards: noOfLikedFavCards)),
      child: Hero(
        tag: item.id,
        child: SizedBox(
          height: 140,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Container(
                  width: 75,
                  height: 75,
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item.name.capitalize,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    height: 22 / 8,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
