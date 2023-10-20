// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/datetime_serializer.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  factory ChatRoom({
    @JsonKey(includeIfNull: false) required Map<String, List<String>> participants,
    @JsonKey(includeIfNull: false) @DatetimeSerializer() DateTime? lastMessageTime,
    @JsonKey(includeIfNull: false) @DatetimeSerializer() DateTime? creationTime,
    @JsonKey(includeIfNull: false) @DatetimeSerializer() Map<String, DateTime>? lastReadTime,
    String? creatorId,
    String? lastMessage,
    @JsonKey(includeToJson: false) String? firestoreDocId,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(String docId, Map<String, dynamic> json) => _$ChatRoomFromJson(json).copyWith(firestoreDocId: docId);
}
