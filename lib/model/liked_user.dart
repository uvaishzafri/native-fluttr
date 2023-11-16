// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/user.dart';
import 'package:native/util/datetime_serializer.dart';

part 'liked_user.freezed.dart';
part 'liked_user.g.dart';

@freezed
class LikedUser with _$LikedUser {
  factory LikedUser({
    @JsonKey(includeIfNull: false) User? user,
    @JsonKey(includeIfNull: false) @DatetimeSerializer() DateTime? updatedAt,
  }) = _LikedUser;

  factory LikedUser.fromJson(Map<String, dynamic> json) =>
      _$LikedUserFromJson(json);
}
