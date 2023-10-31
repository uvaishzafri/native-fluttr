import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:native/dummy_data.dart';
import 'package:native/model/chat_room.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/exceptions.dart';

@lazySingleton
class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _firestore
        .collection('inAppUsers')
        .doc('chats')
        .collection('chat_rooms')
        .orderBy('participants.$userId')
        // .where('participants', arrayContains: "5v4PoKCawiazfNwBWoUNWi2WFDo2")
        .withConverter(
          fromFirestore: (snapshot, options) => ChatRoom.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((snapshots) => snapshots.docs)
        .asyncMap((event) async {
      List<ChatRoom> rooms = [];
      for (var element in event) {
        var data = element.data();
        // if (data.lastReadTime?[userId] != null) {
        final count = await getUnreadMsgCount(data.firestoreDocId!, data.lastReadTime?[userId]?.millisecondsSinceEpoch);
        if (count.isRight) {
          data = data.copyWith(unreadCount: count.right);
        }
        // }
        rooms.add(data);
      }
      return rooms;
    });
    // .map((document) => document.map((e) => e.data()).toList());
    // return Stream.fromFutures([
    //   Future.delayed(
    //       const Duration(seconds: 2),
    //       () => [
    //             dummyChatList[0]
    //           ]),
    //   Future.delayed(const Duration(seconds: 4), () => dummyChatList),
    // ]);
  }

  Future<Either<AppException, bool>> createChat(ChatRoom chat) async {
    try {
      await _firestore
          .collection('inAppUsers')
          .doc('chats')
          .collection('chat_rooms')
          .withConverter<ChatRoom>(
            fromFirestore: (snapshot, options) => ChatRoom.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          )
          .add(chat);
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Stream<List<Message>> getChatMessages(String chatRoomDocId) {
    return _firestore
        .collection('inAppUsers')
        .doc('chats')
        .collection('chat_rooms')
        .doc(chatRoomDocId)
        .collection('message')
        .orderBy('creationDate', descending: true)
        .withConverter(
          fromFirestore: (snapshot, options) => Message.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((snapshots) => snapshots.docs)
        .map((document) => document.map((e) => e.data()).toList());
  }

  Future<Either<AppException, bool>> createChatMessage(String chatRoomDocId, Message message) async {
    try {
      await _firestore
          .collection('inAppUsers')
          .doc('chats')
          .collection('chat_rooms')
          .doc(chatRoomDocId)
          .collection('message')
          .withConverter<Message>(
            fromFirestore: (snapshot, options) => Message.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          )
          .add(message);
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> updateUserDeviceToken(String userId, String deviceId, String deviceToken) async {
    try {
      await _firestore.collection('inAppUsers').doc(userId).collection('device').doc('deviceTokens').set(
        {deviceId: deviceToken},
        SetOptions(merge: true),
      );
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> markChatRoomBlocked(String chatRoomDocId) async {
    try {
      await _firestore
          .collection('inAppUsers')
          .doc('chats')
          .collection('chat_rooms')
          .doc(chatRoomDocId)
          .set({"blocked": true}, SetOptions(merge: true));
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> updateMsgReadTime(String chatRoomDocId, String userId) async {
    try {
      await _firestore.collection('inAppUsers').doc('chats').collection('chat_rooms').doc(chatRoomDocId).update(
        {
          'lastReadTime.$userId': DateTime.now().millisecondsSinceEpoch,
        },
      );
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> updateLastMsgDetails(String chatRoomDocId, String message) async {
    try {
      await _firestore.collection('inAppUsers').doc('chats').collection('chat_rooms').doc(chatRoomDocId).set({
        "lastMessage": message,
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
      return const Right(true);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, int>> getUnreadMsgCount(String chatRoomDocId, int? lastReadTime) async {
    try {
      final query = await _firestore
          .collection('inAppUsers')
          .doc('chats')
          .collection('chat_rooms')
          .doc(chatRoomDocId)
          .collection('message')
          .where("creationDate", isGreaterThan: lastReadTime)
          .count()
          .get();
      return Right(query.count);
    } on Exception catch (_) {
      return Left(CustomException());
    }
  }
}
