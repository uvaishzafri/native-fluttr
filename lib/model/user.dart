// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/native_card/meta.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(includeIfNull: false) String? uid,
    @JsonKey(includeIfNull: false) String? displayName,
    @JsonKey(includeIfNull: false) String? photoURL,
    @JsonKey(includeIfNull: false) String? email,
    @JsonKey(includeIfNull: false) bool? emailVerified,
    @JsonKey(includeIfNull: false) String? phoneNumber,
    @JsonKey(includeIfNull: false) bool? phoneNumberVerified,
    @JsonKey(includeIfNull: false) Meta? native,
    @JsonKey(includeIfNull: false) CustomClaims? customClaims,
    @JsonKey(includeIfNull: false) bool? hasActiveSubscription,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
