// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/liked_user.dart';
import 'package:native/model/user.dart';

part 'likes_model.freezed.dart';
part 'likes_model.g.dart';

@freezed
class LikesModel with _$LikesModel {
  factory LikesModel({
    @JsonKey(includeIfNull: false) List<LikedUser>? fromMe,
    @JsonKey(includeIfNull: false) List<LikedUser>? toMe,
  }) = _LikesModel;

  factory LikesModel.fromJson(Map<String, dynamic> json) =>
      _$LikesModelFromJson(json);
}
