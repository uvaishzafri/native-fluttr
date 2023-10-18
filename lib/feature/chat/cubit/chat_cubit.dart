import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/chat_room.dart';
import 'package:native/repo/firestore_repository.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/exceptions.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@lazySingleton
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatRepository) : super(const ChatState.initial()) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      getChatRooms(currentUser.uid);
    }
  }

  final FirestoreRepository _chatRepository;

  void createSingleChatRoom(ChatRoom chat) async {
    emit(const ChatState.loading());

    var response = await _chatRepository.createChat(chat);

    response.fold((left) {
      emit(ChatState.error(appException: left));
    }, (right) {
      emit(const ChatState.chatCreated());
    });
  }

  void getChatRooms(String userId) async {
    emit(const ChatState.loading());

    _chatRepository.getChatRooms(userId).listen((event) {
      emit(ChatState.chatRoomsFetched(chatRooms: event));
    }, onError: (err) {
      emit(ChatState.error(appException: CustomException()));
    });

    // response.fold((left) {
    //   emit(ChatState.error(appException: left));
    // }, (right) {
    //   emit(const ChatState.chatCreated());
    // });
  }

  void createChatMessage(String chatRoomDocId, Message message) async {
    emit(const ChatState.loading());

    var response = await _chatRepository.createChatMessage(chatRoomDocId, message);

    ///TODO also update chat room details
    response.fold((left) {
      emit(ChatState.error(appException: left));
    }, (right) {
      emit(const ChatState.chatCreated());
    });
  }

  void getChatMessages(String chatRoomDocId) async {
    // emit(const ChatState.loading());

    _chatRepository.getChatMessages(chatRoomDocId).listen(
      (event) {
        emit(ChatState.chatMessagesFetched(chatMessages: event.map((e) => e.toTextMessage()).toList()));
      },
      onError: (_) {
        emit(ChatState.error(appException: CustomException()));
      },
    );

    // response.fold((left) {
    //   emit(ChatState.error(appException: left));
    // }, (right) {
    //   emit(const ChatState.chatCreated());
    // });
  }
}
