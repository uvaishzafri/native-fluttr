// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'advice.freezed.dart';
part 'advice.g.dart';

@freezed
class Advice with _$Advice {
  factory Advice({
    @JsonKey(includeIfNull: false) List<String>? descriptions,
  }) = _Advice;

  factory Advice.fromJson(Map<String, dynamic> json) => _$AdviceFromJson(json);
}
