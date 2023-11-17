import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';
import 'package:native/util/string_ext.dart';
import 'package:native/widget/fav_card/items_grid/single_item.dart';

import '../../../../model/fav_card/fav_card_category.dart';
import '../../../../model/fav_card/fav_card_items/fav_card_items.dart';
import '../../../feature/fav_card/cubit/fav_card_cubit.dart';

class SingleCategoryGrid extends StatelessWidget {
  final FavCardCategoryModel selectedCategory;
  final List<FavCardItemModel> items;

  const SingleCategoryGrid(
      {super.key, required this.selectedCategory, required this.items});

  @override
  Widget build(BuildContext context) {
    final favCardCubit = BlocProvider.of<FavCardCubit>(context);
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
        GridView.count(
          childAspectRatio: 0.72,
          physics: const ScrollPhysics(),
          crossAxisCount: 4,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(items.length, (index) {
            return SingleItem(item: items[index]);
          }),
        ),
      ],
    );
  }
}
