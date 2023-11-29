// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/native_card/advice.dart';
import 'package:native/model/native_card/birthday.dart';
import 'package:native/model/native_card/love.dart';
import 'package:native/model/native_card/meta.dart';
import 'package:native/model/native_card/personality.dart';

import '../../feature/fav_card/models/fav_card_items/fav_card_items.dart';

part 'native_card.freezed.dart';
part 'native_card.g.dart';

@freezed
class NativeCard with _$NativeCard {
  factory NativeCard({
    @JsonKey(includeIfNull: false) String? gender,
    @JsonKey(includeIfNull: false) Birthday? birthday,
    @JsonKey(includeIfNull: false) Meta? meta,
    @JsonKey(includeIfNull: false) Personality? personality,
    @JsonKey(includeIfNull: false) Love? love,
    @JsonKey(includeIfNull: false) Advice? partner,
    @JsonKey(includeIfNull: false) Advice? advice,
    @JsonKey(includeIfNull: false) Advice? ideasPlan,
    //TODO: Implement this
    @JsonKey(includeIfNull: false) List<FavCardItemModel>? favCardInterests,
    //TODO: Implement this
    @JsonKey(includeIfNull: false) Map<String, int>? favCardTrends,
  }) = _NativeCard;

  factory NativeCard.fromJson(Map<String, dynamic> json) =>
      _$NativeCardFromJson(json);
}
