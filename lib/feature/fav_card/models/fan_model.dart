// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/user.dart';

part 'fan_model.freezed.dart';
part 'fan_model.g.dart';

@freezed
class FanModel with _$FanModel {
  factory FanModel({
    @JsonKey(includeIfNull: false) required String comment,
    @JsonKey(includeIfNull: false) required User user,
  }) = _FanModel;

  factory FanModel.fromJson(Map<String, dynamic> json) =>
      _$FanModelFromJson(json);
}
