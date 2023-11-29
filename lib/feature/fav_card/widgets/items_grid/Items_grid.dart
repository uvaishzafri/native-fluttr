import 'package:flutter/material.dart';
import 'package:native/feature/fav_card/widgets/items_grid/what_fav_card/what_fav_card_contracted.dart';
import 'package:native/feature/fav_card/widgets/items_grid/what_fav_card/what_fav_card_extended.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';

import '../../models/fav_card_category_model.dart';
import '../../models/fav_card_items/fav_card_items.dart';
import 'single_category_grid.dart';

class ItemsGrid extends StatelessWidget {
  final FavCardCategoryModel selectedCategory;
  final List<FavCardItemModel> items;
  final int noOfLikedFavCards;
  final bool hasCompletedFavCardOnBoarding;

  const ItemsGrid(
      {super.key,
      required this.selectedCategory,
      required this.items,
      required this.noOfLikedFavCards,
      required this.hasCompletedFavCardOnBoarding});

  @override
  Widget build(BuildContext context) {
    if (selectedCategory.name.stringify().toUpperCase() == "TOP") {
      return Column(
        children: [
          (hasCompletedFavCardOnBoarding == false)
              ? const WhatFavCardExtended()
              : const WhatFavCarsContracted(),
          SingleCategoryGrid(
            selectedCategory: recommendedListModel,
            items: filterItems(
                selectedCategory:
                    selectedCategory.name.stringify().toUpperCase(),
                items: items),
            restrictColumns: true,
            noOfLikedFavCards: noOfLikedFavCards,
          ),
          SingleCategoryGrid(
            selectedCategory: popularListModel,
            items: filterItems(
                selectedCategory:
                    selectedCategory.name.stringify().toUpperCase(),
                items: items),
            restrictColumns: true,
            noOfLikedFavCards: noOfLikedFavCards,
          )
        ],
      );
    } else {
      return Column(
        children: [
          SingleCategoryGrid(
            selectedCategory: selectedCategory,
            items: filterItems(
              selectedCategory: selectedCategory.name.stringify().toUpperCase(),
              items: items,
            ),
            noOfLikedFavCards: noOfLikedFavCards,
          )
        ],
      );
    }
  }

  /// The function filters a list of `FavCardItemModel` items based on a selected category.
  ///
  /// Args:
  ///   selectedCategory (String): The selected category is a String that represents the category that the user has selected for filtering the
  /// items.
  ///   items (List<FavCardItemModel>): A list of FavCardItemModel objects. Each FavCardItemModel object has a property called "categories"
  /// which is a list of strings representing the categories of the item.
  ///
  /// Returns:
  ///   a List of FavCardItemModel objects that match the selected category.
  List<FavCardItemModel> filterItems(
      {required String selectedCategory,
      required List<FavCardItemModel> items}) {
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
