import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required bool isExpired,
    required Long expiry,
  }) = _AuthResult;
}
