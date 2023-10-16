// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rgb.freezed.dart';
part 'rgb.g.dart';

@freezed
class Rgb with _$Rgb {
  factory Rgb({
    @JsonKey(includeIfNull: false) String? r,
    @JsonKey(includeIfNull: false) String? g,
    @JsonKey(includeIfNull: false) String? b,
  }) = _Rgb;

  factory Rgb.fromJson(Map<String, dynamic> json) => _$RgbFromJson(json);
}
