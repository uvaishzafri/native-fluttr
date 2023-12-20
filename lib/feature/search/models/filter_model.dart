// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';

import '../../../model/user.dart';

part 'filter_model.freezed.dart';

part 'filter_model.g.dart';

@freezed
class FilterModel with _$FilterModel {
  factory FilterModel({
    @JsonKey(includeIfNull: false) required List<String> selectedReligions,
    @JsonKey(includeIfNull: false) required List<String> selectedLanguages,
    @JsonKey(includeIfNull: false) required List<int> minMaxAge,
    @JsonKey(includeIfNull: false) required List<String> selectedNativeTypes,
    @JsonKey(includeIfNull: false) required Map<String, String> needs,
    @JsonKey(includeIfNull: false) required List<int> minMaxNativeEnergy,
    @JsonKey(includeIfNull: false) required List<User> users,
  }) = _FilterModel;

  factory FilterModel.fromJson(Map<String, dynamic> json) => _$FilterModelFromJson(json);

  factory FilterModel.defaultValues() => FilterModel(
      selectedReligions: [],
      selectedLanguages: [],
      selectedNativeTypes: [],
      needs: {for (var need in needs) need: '0%'},
      minMaxAge: [25, 30],
      minMaxNativeEnergy: [12, 20],
      users: []);
}
