// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter.freezed.dart';
part 'parameter.g.dart';

@freezed
class Parameter with _$Parameter {
  factory Parameter({
    @JsonKey(includeIfNull: false) num? finance,
    @JsonKey(includeIfNull: false) num? fun,
    @JsonKey(includeIfNull: false) num? active,
    @JsonKey(includeIfNull: false) num? knowledge,
    @JsonKey(includeIfNull: false) num? independence,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);
}
