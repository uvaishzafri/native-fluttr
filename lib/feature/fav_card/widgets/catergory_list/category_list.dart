import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/fav_card/fav_card_constants.dart';
import '../../cubit/fav_card_cubit.dart';
import 'fav_card_category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final favCardCubit = BlocProvider.of<FavCardCubit>(context);
    return BlocBuilder<FavCardCubit, FavCardState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Row(children: categoriesList(cubit: favCardCubit, state: state))),
      );
    });
  }

  List<Widget> categoriesList({required FavCardCubit cubit, required FavCardState state}) {
    List<Widget> categoriesList = [];
    for (int i = 0; i < favCardCategories.length; i++) {
      categoriesList.add(GestureDetector(
        onTap: () => cubit.addRemoveCategory(
            category: favCardCategories[i],
            items: (state is Data) ? state.items : [],
            hasCompletedFavCardOnBoarding: (state is Data) ? state.hasCompletedFavCardOnBoarding : false),
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: (i == 0) ? 0 : 10),
          child: FavCardCategory(
            model: favCardCategories[i],
            radius: 26,
            isCaps: true,
            isSelected: (state is Data) ? (state.selectedCategory == favCardCategories[i]) : false,
          ),
        ),
      ));
    }
    return categoriesList;
  }
}
