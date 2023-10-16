// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday.freezed.dart';
part 'birthday.g.dart';

@freezed
class Birthday with _$Birthday {
  factory Birthday({
    @JsonKey(includeIfNull: false) String? year,
    @JsonKey(includeIfNull: false) String? month,
    @JsonKey(includeIfNull: false) String? day,
  }) = _Birthday;

  factory Birthday.fromJson(Map<String, dynamic> json) => _$BirthdayFromJson(json);
}
