// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'love.freezed.dart';
part 'love.g.dart';

@freezed
class Love with _$Love {
  factory Love({
    @JsonKey(includeIfNull: false) String? hashTags,
    @JsonKey(includeIfNull: false) List<String>? descriptions,
  }) = _Love;

  factory Love.fromJson(Map<String, dynamic> json) => _$LoveFromJson(json);
}
