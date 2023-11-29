import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/fav_card/fav_card_constants.dart';

part 'fav_card_category_model.freezed.dart';

@freezed
class FavCardCategoryModel with _$FavCardCategoryModel {
  const factory FavCardCategoryModel({
    required FavCardCategoryEnum name,
    required Color color,
    required String imageAddress,
  }) = _FavCardCategoryModel;
}
