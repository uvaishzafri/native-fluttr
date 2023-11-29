import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_card_items.freezed.dart';
part 'fav_card_items.g.dart';

@freezed
class FavCardItemModel with _$FavCardItemModel {
  const factory FavCardItemModel(
      {required String id,
      required String name,
      required List<String> categories,
      required String imageAddress,
      required int likes,
      required String?
          comment // This is the comment given by current user to this fav Card.
      }) = _FavCardItemModel;

  factory FavCardItemModel.fromJson(Map<String, dynamic> json) =>
      _$FavCardItemModelFromJson(json);
}
