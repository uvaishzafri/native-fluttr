import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/fav_card/fav_card_category.dart';

enum FavCardCategoryEnum {
  @JsonValue('TOP')
  top,
  @JsonValue('love')
  love,
  @JsonValue('MUSIC')
  music,
  @JsonValue('HOBBY')
  hobby,
  @JsonValue('PSYCHOLOGY')
  psychology,
  @JsonValue('LIFE')
  life,
  @JsonValue('ANIME')
  anime,
  @JsonValue('BOOK')
  book,
  @JsonValue('JOB')
  job,
  @JsonValue('SPORT')
  sport,
  @JsonValue('FASHION')
  fashion,
  @JsonValue('BIKE')
  bike,
  @JsonValue('TV')
  tv,
  @JsonValue('MOVIE')
  movie,
  @JsonValue('ANIMAL')
  animal,
  @JsonValue('RECOMMENDED')
  recommended,
  @JsonValue('POPULAR')
  popular
}

extension StringExt on FavCardCategoryEnum {
  String stringify() {
    return toString().split('.').last;
  }
}

List<FavCardCategoryModel> favCardCategories = [
  const FavCardCategoryModel(name: FavCardCategoryEnum.top, color: Colors.red, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.animal, color: Colors.green, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.anime, color: Colors.black, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.bike, color: Colors.blue, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.book, color: Colors.brown, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.hobby, color: Colors.grey, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.fashion, color: Colors.pink, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.movie, color: Colors.orange, imageAddress: "assets/fav_card/top_fav_card.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.psychology, color: Colors.yellow, imageAddress: "assets/fav_card/top_fav_card.svg"),
];

FavCardCategoryModel popularListModel = const FavCardCategoryModel(
    name: FavCardCategoryEnum.popular,
    color: Colors.red,
    imageAddress: "assets/"
        "fav_card/top_fav_card.svg");
FavCardCategoryModel recommendedListModel = const FavCardCategoryModel(
    name: FavCardCategoryEnum.recommended,
    color: Colors.red,
    imageAddress: "assets/"
        "fav_card/top_fav_card.svg");
