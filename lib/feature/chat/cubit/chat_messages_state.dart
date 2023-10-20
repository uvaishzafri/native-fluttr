part of 'chat_messages_cubit.dart';

@freezed
class ChatMessagesState with _$ChatMessagesState {
  const factory ChatMessagesState.initial() = Initial;
  const factory ChatMessagesState.loading() = Loading;
  const factory ChatMessagesState.errorState({required AppException appException}) = ErrorState;
  const factory ChatMessagesState.chatMessagesFetched({required List<types.TextMessage> chatMessages}) =
      ChatMessagesFetched;
}
