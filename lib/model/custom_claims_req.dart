import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_claims_req.freezed.dart';
part 'custom_claims_req.g.dart';

@freezed
class CustomClaimsReq with _$CustomClaimsReq {
  factory CustomClaimsReq({
    String? gender,
    String? location,
    String? religion,
    String? community,
    String? birthday,
  }) = _CustomClaimsReq;

  factory CustomClaimsReq.fromJson(Map<String, dynamic> json) => _$CustomClaimsReqFromJson(json);
}
