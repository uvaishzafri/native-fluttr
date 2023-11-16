// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/looking_for.dart';

part 'user_prefs.freezed.dart';
part 'user_prefs.g.dart';

@freezed
class UserPrefs with _$UserPrefs {
  factory UserPrefs({
    @JsonKey(includeIfNull: false) LookingFor? lookingFor,
  }) = _UserPrefs;

  factory UserPrefs.fromJson(Map<String, dynamic> json) =>
      _$UserPrefsFromJson(json);
}
