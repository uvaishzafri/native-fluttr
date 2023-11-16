import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_req.freezed.dart';
part 'update_user_req.g.dart';

@freezed
class UpdateUserReq with _$UpdateUserReq {
  factory UpdateUserReq({
    String? avatar,
    String? gender,
    String? birthday,
    String? displayName,
  }) = _UpdateUserReq;

  factory UpdateUserReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserReqFromJson(json);
}
