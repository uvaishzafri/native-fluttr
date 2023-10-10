import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_claims.freezed.dart';
part 'custom_claims.g.dart';

@freezed
class CustomClaims with _$CustomClaims {
  factory CustomClaims({
    required String gender,
    required String birthday,
    required String religion,
    required String community,
    required String location,
    required String about,
  }) = _CustomClaims;

  factory CustomClaims.fromJson(Map<String, dynamic> json) => _$CustomClaimsFromJson(json);
}
