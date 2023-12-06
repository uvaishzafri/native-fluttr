// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';

part 'looking_for.freezed.dart';
part 'looking_for.g.dart';

@freezed
class LookingFor with _$LookingFor {
  factory LookingFor({
    @JsonKey(includeIfNull: false) Gender? gender,
    @JsonKey(includeIfNull: false) List<String>? location,
    @JsonKey(includeIfNull: false) List<String>? religion,
    @JsonKey(includeIfNull: false) List<String>? community,
    @JsonKey(includeIfNull: false) num? minAge,
    @JsonKey(includeIfNull: false) num? maxAge,
  }) = _LookingFor;

  factory LookingFor.fromJson(Map<String, dynamic> json) =>
      _$LookingForFromJson(json);
}
