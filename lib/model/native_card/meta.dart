// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/native_card/colour.dart';
import 'package:native/model/native_card/native_type.dart';
import 'package:native/model/native_card/parameter.dart';
import 'package:native/model/native_type.dart';
import 'package:native/util/datetime_serializer.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

@freezed
class Meta with _$Meta {
  factory Meta({
    @JsonKey(includeIfNull: false) String? slogan,
    @JsonKey(includeIfNull: false) @TypeConverter() NativeTypeEnum? type,
    @JsonKey(includeIfNull: false)
    @TypeConverter()
    List<NativeTypeEnum?>? matchTypes,
    @JsonKey(includeIfNull: false) Colour? color,
    @JsonKey(includeIfNull: false) int? energyScore,
    @JsonKey(includeIfNull: false) Parameter? parameter,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
