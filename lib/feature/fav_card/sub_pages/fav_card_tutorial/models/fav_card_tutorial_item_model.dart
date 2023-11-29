// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_card_tutorial_item_model.freezed.dart';
part 'fav_card_tutorial_item_model.g.dart';

@freezed
class FavCardTutorialItemModel with _$FavCardTutorialItemModel {
  factory FavCardTutorialItemModel({
    @JsonKey(includeIfNull: false) required String title,
    @JsonKey(includeIfNull: false) required String stepIconImageAddress,
    @JsonKey(includeIfNull: false) required double stepIconImageWidth,
    @JsonKey(includeIfNull: false) required double stepIconImageHeight,
    @JsonKey(includeIfNull: false) required String stepContentImageAddress,
    @JsonKey(includeIfNull: false) required double stepContentImageWidth,
    @JsonKey(includeIfNull: false) required double stepContentImageHeight,
  }) = _FavCardTutorialItemModel;

  factory FavCardTutorialItemModel.fromJson(Map<String, dynamic> json) =>
      _$FavCardTutorialItemModelFromJson(json);
}
