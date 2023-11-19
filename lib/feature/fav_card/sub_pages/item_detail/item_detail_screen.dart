import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../i18n/translations.g.dart';
import '../../models/fav_card_items/fav_card_items.dart';

@RoutePage()
class ItemDetailScreen extends StatelessWidget {
  final FavCardItemModel item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_rounded)),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      t.strings.myFavCard,
                      style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 34),
            Row(
              children: [
                Hero(
                  tag: item.id,
                  child: Container(
                    width: 100,
                    height: 90,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: item.image.image,
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 22),
                    _categoryList(),
                    const SizedBox(height: 22),
                    Text(
                      "${item.likes.toString()} ${t.strings.peopleLike}",
                      style: GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _categoryList() {
    List<Widget> categories = [];
    for (int i = 0; i < min(3, item.categories.length); i++) {
      categories.add(categoryWidget(item.categories[i]));
    }
    return Container();
  }

  Widget categoryWidget(String category) {
    return Container();
  }
}
