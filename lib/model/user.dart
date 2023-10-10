import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/custom_claims.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String displayName,
    required String photoURL,
    required String email,
    required bool emailVerified,
    required String phoneNumber,
    required bool phoneNumberVerified,
    required CustomClaims customClaims,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
