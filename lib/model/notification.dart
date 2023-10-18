// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  factory Notification({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) String? fromUid,
    @JsonKey(includeIfNull: false) int? timestamp,
    @JsonKey(includeIfNull: false) NotificationType? type,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}
