// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/datetime_serializer.dart';

part 'custom_claims.freezed.dart';
part 'custom_claims.g.dart';

@freezed
class CustomClaims with _$CustomClaims {
  factory CustomClaims({
    @JsonKey(includeIfNull: false) Gender? gender,
    @JsonKey(includeIfNull: false) String? birthday,
    @JsonKey(includeIfNull: false) String? religion,
    @JsonKey(includeIfNull: false) String? community,
    @JsonKey(includeIfNull: false) String? location,
    @JsonKey(includeIfNull: false) String? about,
  }) = _CustomClaims;

  factory CustomClaims.fromJson(Map<String, dynamic> json) => _$CustomClaimsFromJson(json);

// @override
//   Map<String, dynamic> toJson() {
//     return _$CustomClaimsToJson(this)..['gender'] = _toUpper(this.gender);
//   }

  // // Custom method to convert to uppercase
  // String? _toUpper(String? value) {
  //   return value?.toUpperCase();
  // }
}
