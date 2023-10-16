part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = Initial;
  const factory ChatState.loading() = Loading;
  const factory ChatState.error({required AppException appException}) = Error;
  const factory ChatState.chatCreated() = ChatCreated;
  const factory ChatState.chatRoomsFetched({required List<ChatRoom> chatRooms}) = ChatRoomFetched;
  const factory ChatState.chatMessagesFetched({required List<types.TextMessage> chatMessages}) = ChatMessagesFetched;
}
