// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_card_trends_model.freezed.dart';
part 'fav_card_trends_model.g.dart';

@freezed
class FavCardTrendsModel with _$FavCardTrendsModel {
  factory FavCardTrendsModel({
    @JsonKey(includeIfNull: false) List<String>? descriptions,
  }) = _FavCardTrendsModel;

  factory FavCardTrendsModel.fromJson(Map<String, dynamic> json) =>
      _$FavCardTrendsModelFromJson(json);
}
