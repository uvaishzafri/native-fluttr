import 'package:freezed_annotation/freezed_annotation.dart';

import 'fan_model.dart';

part 'item_detail_model.freezed.dart';

part 'item_detail_model.g.dart';

@freezed
class ItemDetailModel with _$ItemDetailModel {
  const factory ItemDetailModel({
    required List<FanModel> fans,
    required bool isAlreadyLiked,
  }) = _ItemDetailModel;

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailModelFromJson(json);
}
