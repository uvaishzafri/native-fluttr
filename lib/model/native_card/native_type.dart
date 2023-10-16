// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_type.freezed.dart';
part 'native_type.g.dart';

@freezed
class NativeType with _$NativeType {
  factory NativeType({
    @JsonKey(includeIfNull: false) String? en,
    @JsonKey(includeIfNull: false) String? ja,
  }) = _NativeType;

  factory NativeType.fromJson(Map<String, dynamic> json) => _$NativeTypeFromJson(json);
}
