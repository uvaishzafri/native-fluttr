// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hsv.freezed.dart';
part 'hsv.g.dart';

@freezed
class Hsv with _$Hsv {
  factory Hsv({
    @JsonKey(includeIfNull: false) String? s,
    @JsonKey(includeIfNull: false) String? v,
    @JsonKey(includeIfNull: false) String? h,
  }) = _Hsv;

  factory Hsv.fromJson(Map<String, dynamic> json) => _$HsvFromJson(json);
}
