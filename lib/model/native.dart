import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'native.freezed.dart';

@freezed
class Native with _$Native {
  const factory Native({
    required String user,
    required NativeType type,
    required int energy,
    required List<NativeType> goodFits,
  }) = _Native;
}

@freezed
class NativeType with _$NativeType {
  const factory NativeType({
    required String name,
    required Color color,
    required ImageProvider imageProvider,
  }) = _NativeType;

  factory NativeType.field() => _NativeType(
        name: "Field",
        color: Colors.amber,
        imageProvider: Image.asset('assets/home/ic_native_field.png').image,
      );
}
