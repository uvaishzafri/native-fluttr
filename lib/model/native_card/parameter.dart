// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter.freezed.dart';
part 'parameter.g.dart';

@freezed
class Parameter with _$Parameter {
  factory Parameter({
    @JsonKey(includeIfNull: false) String? finance,
    @JsonKey(includeIfNull: false) String? fun,
    @JsonKey(includeIfNull: false) String? active,
    @JsonKey(includeIfNull: false) String? knowledge,
    @JsonKey(includeIfNull: false) String? independence,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, dynamic> json) => _$ParameterFromJson(json);
}
