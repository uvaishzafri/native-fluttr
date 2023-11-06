import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/chat_room.dart';
import 'package:native/repo/firestore_repository.dart';
import 'package:native/util/exceptions.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@lazySingleton
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatRepository) : super(const ChatState.initial()) {
    getChatRooms();
  }

  final FirestoreRepository _chatRepository;
  // final UserRepository _userRepository;
  List<types.TextMessage> chatMessages = [];
  List<ChatRoom> chatRooms = [];

  void createSingleChatRoom(ChatRoom chat) async {
    emit(const ChatState.loading());

    var response = await _chatRepository.createChat(chat);

    response.fold((left) {
      emit(ChatState.error(appException: left));
    }, (right) {
      // emit(const ChatState.chatCreated());
    });
  }

  void getChatRooms() async {
    // emit(const ChatState.loading());
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(ChatState.error(appException: CustomException('User id not found')));
    }

    // _chatRepository.getChatRooms(currentUser!.uid).listen((event) async {
    //   chatRooms.clear();

    //   for (var chatRoom in event) {
    //     for (var participant in chatRoom.participants.keys) {
    //       if (participant != currentUser.uid) {
    //         List<String> usrDetails;
    //         final user = await _userRepository.getUserDetails(participant);
    //         if (user.isRight) {
    //           usrDetails = [user.right.photoURL!, user.right.displayName!];
    //           chatRoom.participants[participant] = usrDetails;
    //         }
    //       }
    //     }
    //     chatRooms.add(chatRoom);
    //   }
    // chatRooms.addAll(event);
    _chatRepository.getChatRooms(currentUser!.uid).listen((event) {
      emit(const ChatState.loading());
      chatRooms.clear();
      chatRooms.addAll(event);
      emit(ChatState.chatRoomsFetched(chatRooms: chatRooms));
    }, onError: (err) {
      // emit(ChatState.error(appException: CustomException()));
    });

    // response.fold((left) {
    //   emit(ChatState.error(appException: left));
    // }, (right) {
    //   emit(const ChatState.chatCreated());
    // });
  }

  updateMsgReadTime(String chatRoomDocId) {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        _chatRepository.updateMsgReadTime(chatRoomDocId, currentUser.uid);
      }
    } catch (e) {
      //swallow
    }
  }

  updateLastMsgDetails(String chatRoomDocId, String message) {
    try {
      _chatRepository.updateLastMsgDetails(chatRoomDocId, message);
    } catch (e) {
      //swallow
    }
  }
}
