import 'package:flutter/material.dart';
import 'package:native/model/fav_card/fav_card_items/fav_card_items.dart';
import 'package:native/widget/fav_card/items_grid/single_category_grid.dart';

import '../../../../model/fav_card/fav_card_category.dart';
import '../../../util/fav_card/fav_card_constants.dart';

class ItemsGrid extends StatelessWidget {
  final FavCardCategoryModel selectedCategory;
  final List<FavCardItemModel> items;

  const ItemsGrid({super.key, required this.selectedCategory, required this.items});

  @override
  Widget build(BuildContext context) {
    if (selectedCategory.name.stringify().toUpperCase() == "TOP") {
      return Column(
        children: [
          SingleCategoryGrid(
              selectedCategory: recommendedListModel,
              items: filterItems(selectedCategory: selectedCategory.name.stringify().toUpperCase(), items: items)),
          SingleCategoryGrid(
              selectedCategory: popularListModel,
              items: filterItems(selectedCategory: selectedCategory.name.stringify().toUpperCase(), items: items))
        ],
      );
    } else {
      return Column(
        children: [
          SingleCategoryGrid(
              selectedCategory: selectedCategory,
              items: filterItems(selectedCategory: selectedCategory.name.stringify().toUpperCase(), items: items))
        ],
      );
    }
  }

  List<FavCardItemModel> filterItems({required String selectedCategory, required List<FavCardItemModel> items}) {
    List<FavCardItemModel> result = [];
    for (int i = 0; i < items.length; i++) {
      for (int j = 0; j < items[i].categories.length; j++) {
        if (items[i].categories[j].toUpperCase() == selectedCategory) {
          result.add(items[i]);
        }
      }
    }
    return result;
  }
}
