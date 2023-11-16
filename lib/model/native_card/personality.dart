// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'personality.freezed.dart';
part 'personality.g.dart';

@freezed
class Personality with _$Personality {
  factory Personality({
    @JsonKey(includeIfNull: false) String? hashTags,
    @JsonKey(includeIfNull: false) List<String>? descriptions,
    @JsonKey(includeIfNull: false) String? sameKindCelebrity,
  }) = _Personality;

  factory Personality.fromJson(Map<String, dynamic> json) =>
      _$PersonalityFromJson(json);
}
