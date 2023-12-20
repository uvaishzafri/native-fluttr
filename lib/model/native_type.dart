// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'native.freezed.dart';

// @freezed
// class Native with _$Native {
//   const factory Native({
//     required String user,
//     required String age,
//     required String imageUrl,
//     required NativeType type,
//     required int energy,
//     required List<NativeType> goodFits,
//   }) = _Native;
// }

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_type.freezed.dart';

enum NativeTypeEnum {
  fields,
  moon,
  mist,
  mineral,
  diamond,
  tree,
  sun,
  flower,
  ocean,
  mountain,
}

extension StringExt on NativeTypeEnum {
  String stringify() {
    return toString().split('.').last;
  }
}

NativeType getNativeTypeDetail(NativeTypeEnum nativeType) {
  switch (nativeType) {
    case NativeTypeEnum.fields:
      return NativeType.fields();
    case NativeTypeEnum.moon:
      return NativeType.moon();
    case NativeTypeEnum.mist:
      return NativeType.mist();
    case NativeTypeEnum.mineral:
      return NativeType.mineral();
    case NativeTypeEnum.diamond:
      return NativeType.diamond();
    case NativeTypeEnum.sun:
      return NativeType.sun();
    case NativeTypeEnum.flower:
      return NativeType.flower();
    case NativeTypeEnum.tree:
      return NativeType.tree();
    case NativeTypeEnum.ocean:
      return NativeType.ocean();
    case NativeTypeEnum.mountain:
      return NativeType.mountain();
  }
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
        imageProvider: Image.asset('assets/home/ic_native_fields.png').image,
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
  factory NativeType.diamond() => _NativeType(
        name: "Diamond",
        color: Colors.purple,
        imageProvider: Image.asset('assets/home/ic_native_diamond.png').image,
      );
  factory NativeType.tree() => _NativeType(
        name: "Tree",
        color: Colors.green,
        imageProvider: Image.asset('assets/home/ic_native_tree.png').image,
      );
  factory NativeType.sun() => _NativeType(
        name: "Sun",
        color: Colors.amber,
        imageProvider: Image.asset('assets/home/ic_native_sun.png').image,
      );
  factory NativeType.flower() => _NativeType(
        name: "Flower",
        color: Colors.pink,
        imageProvider: Image.asset('assets/home/ic_native_flower.png').image,
      );
  factory NativeType.mountain() => _NativeType(
        name: "Mountain",
        color: Colors.pink,
        imageProvider: Image.asset('assets/home/ic_native_mountain.png').image,
      );
  factory NativeType.ocean() => _NativeType(
        name: "Ocean",
        color: Colors.pink,
        imageProvider: Image.asset('assets/home/ic_native_ocean.png').image,
      );
}
