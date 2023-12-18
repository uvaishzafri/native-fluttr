// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'fav_card_tutorial_item_model.dart';

part 'fav_card_tutorial_model.freezed.dart';
part 'fav_card_tutorial_model.g.dart';

@freezed
class FavCardTutorialModel with _$FavCardTutorialModel {
  factory FavCardTutorialModel({
    @JsonKey(includeIfNull: false) required String title,
    @JsonKey(includeIfNull: false) required List<FavCardTutorialItemModel> steps,
  }) = _FavCardTutorialModel;

  factory FavCardTutorialModel.fromJson(Map<String, dynamic> json) =>
      _$FavCardTutorialModelFromJson(json);
}
