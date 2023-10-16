// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/datetime_serializer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const Message._();
  
  factory Message({
    required String senderId,
    @DatetimeSerializer() required DateTime creationDate,
    @JsonKey(includeToJson: false) String? firestoreDocId,
    required String text,
  }) = _Message;

  factory Message.fromJson(String id, Map<String, dynamic> json) => _$MessageFromJson(json).copyWith(firestoreDocId: id);

  factory Message.fromTextMessage(types.TextMessage textMessage) {
    return Message(
      senderId: textMessage.author.id,
      creationDate: DateTime.fromMillisecondsSinceEpoch(textMessage.createdAt!),
      text: textMessage.text,
    );
  }

  types.TextMessage toTextMessage() {
    return types.TextMessage(
      author: types.User(id: senderId),
      id: senderId,
      text: text,
      createdAt: creationDate.millisecondsSinceEpoch,
    );
  }
}
