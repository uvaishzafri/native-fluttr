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
  @JsonValue('TRAVEL')
  travel,
  @JsonValue('FOOD')
  food,
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
  const FavCardCategoryModel(name: FavCardCategoryEnum.top, color: Color(0xFFBE94C6), imageAddress: "assets/fav_card/fav_category/top.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.love, color: Color(0xFFED7777), imageAddress: "assets/fav_card/fav_category/love.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.travel, color: Color(0xFF97C5F6), imageAddress: "assets/fav_card/fav_category/travel.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.music, color: Color(0xFFF2C8D2), imageAddress: "assets/fav_card/fav_category/music.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.food, color: Color(0xFFBE94C6), imageAddress: "assets/fav_card/fav_category/food.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.job, color: Color(0xFFF3C6D5), imageAddress: "assets/fav_card/fav_category/job.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.life, color: Colors.green, imageAddress: "assets/fav_card/fav_category/life.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.sport, color: Color(0xFFFDC79B), imageAddress: "assets/fav_card/fav_category/sport.svg"),
  const FavCardCategoryModel(name: FavCardCategoryEnum.tv, color: Color(0xFFBE94C6), imageAddress: "assets/fav_card/fav_category/tv.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.animal, color: Color(0xFF98C5F5), imageAddress: "assets/fav_card/fav_category/animal.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.anime, color: Color(0xFFB9E9FF), imageAddress: "assets/fav_card/fav_category/anime.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.bike, color: Color(0xFF99C5F4), imageAddress: "assets/fav_card/fav_category/bike.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.book, color: Color(0xFFCBA5D7), imageAddress: "assets/fav_card/fav_category/book.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.hobby, color: Color(0xFFFDC798), imageAddress: "assets/fav_card/fav_category/hobby.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.fashion, color: Color(0xFFFDF148), imageAddress: "assets/fav_card/fav_category/fashion.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.movie, color: Color(0xFF97C4F6), imageAddress: "assets/fav_card/fav_category/movie.svg"),
  const FavCardCategoryModel(
      name: FavCardCategoryEnum.psychology, color: Color(0xFFC9A5D7), imageAddress: "assets/fav_card/fav_category/psychology.svg"),
];

FavCardCategoryModel popularListModel = const FavCardCategoryModel(
    name: FavCardCategoryEnum.popular,
    color: Color(0xFFBAE9FF),
    imageAddress: "assets/"
        "fav_card/fav_category/popular.svg");
FavCardCategoryModel recommendedListModel = const FavCardCategoryModel(
    name: FavCardCategoryEnum.recommended,
    color: Color(0xFFF3C7D4),
    imageAddress: "assets/"
        "fav_card/fav_category/recommended.svg");
