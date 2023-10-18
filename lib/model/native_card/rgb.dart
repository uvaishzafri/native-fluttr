// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rgb.freezed.dart';
part 'rgb.g.dart';

@freezed
class Rgb with _$Rgb {
  factory Rgb({
    @JsonKey(includeIfNull: false) num? r,
    @JsonKey(includeIfNull: false) num? g,
    @JsonKey(includeIfNull: false) num? b,
  }) = _Rgb;

  factory Rgb.fromJson(Map<String, dynamic> json) => _$RgbFromJson(json);
}
