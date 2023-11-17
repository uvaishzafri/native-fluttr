import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/model/fav_card/fav_card_items/fav_card_items.dart';

class SingleItem extends StatelessWidget {
  final FavCardItemModel item;

  const SingleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  image: item.image.image,
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
    );
  }
}
