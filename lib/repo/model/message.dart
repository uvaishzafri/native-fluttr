// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/datetime_serializer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const Message._();

  factory Message({
    required String senderId,
    @DatetimeSerializer() required DateTime? creationDate,
    @JsonKey(includeToJson: false) String? firestoreDocId,
    required String text,
  }) = _Message;

  factory Message.fromJson(String id, Map<String, dynamic> json) =>
      _$MessageFromJson(json).copyWith(firestoreDocId: id);

  factory Message.fromTextMessage(TextMessage textMessage) {
    return Message(
      senderId: textMessage.author.id,
      creationDate: DateTime.fromMillisecondsSinceEpoch(textMessage.createdAt!),
      text: textMessage.text,
    );
  }

  TextMessage toTextMessage() {
    return TextMessage(
      author: User(id: senderId),
      id: firestoreDocId!,
      text: text,
      createdAt: creationDate?.millisecondsSinceEpoch,
    );
  }
}
