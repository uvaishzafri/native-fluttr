// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/native_card/hsv.dart';
import 'package:native/model/native_card/rgb.dart';

part 'colour.freezed.dart';
part 'colour.g.dart';

@freezed
class Colour with _$Colour {
  factory Colour({
    @JsonKey(includeIfNull: false) String? hex,
    @JsonKey(includeIfNull: false) Hsv? hsv,
    @JsonKey(includeIfNull: false) Rgb? rgb,
  }) = _Colour;

  factory Colour.fromJson(Map<String, dynamic> json) => _$ColourFromJson(json);
}
