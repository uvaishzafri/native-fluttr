import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/feature/fav_card/models/fav_card_items/fav_card_items.dart';

part 'fav_card_data.freezed.dart';

part 'fav_card_data.g.dart';

@freezed
class FavCardDataModel with _$FavCardDataModel {
  const factory FavCardDataModel(
      {required List<FavCardItemModel> items,
      required bool hasCompletedFavCardOnBoarding,
      required int noOfLikedFavCards}) = _FavCardDataModelModel;

  factory FavCardDataModel.fromJson(Map<String, dynamic> json) =>
      _$FavCardDataModelFromJson(json);
}
