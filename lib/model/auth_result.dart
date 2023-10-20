
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/user.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required bool isExpired,
    required int expiry,
  }) = _AuthResult;
}
