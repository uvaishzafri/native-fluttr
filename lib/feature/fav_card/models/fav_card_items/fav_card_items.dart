import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_card_items.freezed.dart';

@freezed
class FavCardItemModel with _$FavCardItemModel {
  const factory FavCardItemModel({
    required String id,
    required String name,
    required List<String> categories,
    required Image image,
    required int likes,
  }) = _FavCardItemModel;
}
