import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/firestore_repository.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/exceptions.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'chat_messages_state.dart';
part 'chat_messages_cubit.freezed.dart';

@lazySingleton
class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  ChatMessagesCubit(this._firestoreRepository) : super(ChatMessagesState.initial());

  final FirestoreRepository _firestoreRepository;

  void createChatMessage(String chatRoomDocId, Message message) async {
    // emit(const ChatState.loading());

    var response = await _firestoreRepository.createChatMessage(chatRoomDocId, message);

    ///TODO also update chat room details
    response.fold((left) {
      emit(ChatMessagesState.errorState(appException: left));
    }, (right) {
      // emit(const ChatState.chatMessageCreated());
    });
  }

  void getChatMessages(String chatRoomDocId) async {
    emit(const ChatMessagesState.loading());

    _firestoreRepository.getChatMessages(chatRoomDocId).listen(
      (event) {
        emit(ChatMessagesState.chatMessagesFetched(chatMessages: event.map((e) => e.toTextMessage()).toList()));
        // chatMessages.addAll(event.map((e) => e.toTextMessage()));
        // emit(ChatState.chatMessagesFetched(chatMessages: chatMessages));
      },
      onError: (_) {
        emit(ChatMessagesState.errorState(appException: CustomException()));
      },
    );

    // response.fold((left) {
    //   emit(ChatState.error(appException: left));
    // }, (right) {
    //   emit(const ChatState.chatCreated());
    // });
  }
}
