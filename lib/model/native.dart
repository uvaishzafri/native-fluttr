import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'native.freezed.dart';

@freezed
class Native with _$Native {
  const factory Native({
    required String user,
    required String age,
    required String imageUrl,
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

  factory NativeType.fields() => _NativeType(
        name: "Fields",
        color: Colors.amber,
        imageProvider: Image.asset('assets/home/ic_native_field.png').image,
      );
  factory NativeType.moon() => _NativeType(
        name: "Moon",
        color: Colors.yellow,
        imageProvider: Image.asset('assets/home/ic_native_moon.png').image,
      );
  factory NativeType.mist() => _NativeType(
        name: "Mist",
        color: Colors.blue,
        imageProvider: Image.asset('assets/home/ic_native_mist.png').image,
      );
  factory NativeType.mineral() => _NativeType(
        name: "Mineral",
        color: Colors.grey,
        imageProvider: Image.asset('assets/home/ic_native_mineral.png').image,
      );
}
