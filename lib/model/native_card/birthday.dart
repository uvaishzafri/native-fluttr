// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.freezed.dart';
part 'birthday.g.dart';

@freezed
class Birthday with _$Birthday {
  factory Birthday({
    @JsonKey(includeIfNull: false) num? year,
    @JsonKey(includeIfNull: false) num? month,
    @JsonKey(includeIfNull: false) num? day,
  }) = _Birthday;

  factory Birthday.fromJson(Map<String, dynamic> json) =>
      _$BirthdayFromJson(json);
}
