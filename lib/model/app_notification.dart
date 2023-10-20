// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/datetime_serializer.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  factory AppNotification({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false) String? fromUid,
    @JsonKey(includeIfNull: false) @DatetimeSerializer() DateTime? timestamp,
    @JsonKey(includeIfNull: false) NotificationType? type,
    @JsonKey(includeIfNull: false) String? content,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
