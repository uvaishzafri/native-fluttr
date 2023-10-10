import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/model/chat.dart';

@lazySingleton
class ChatRepository {
  ChatRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<List<Chat>> getChats(String userId) {
    // return _firestore
    //     .collection('chats')
    //     .where('ids', arrayContains: userId)
    //     .withConverter(
    //       fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
    //       toFirestore: (value, options) => value.toJson(),
    //     )
    //     .snapshots()
    //     .map((snapshots) => snapshots.docs)
    //     .map((document) => document.map((e) => e.data()).toList());
    return Stream.fromFutures([
      Future.delayed(
          Duration(seconds: 2),
          () => [
                Chat(participents: [
                  '1',
                  '2'
                ], lastMessageTime: DateTime.now(), creationTime: DateTime.now(), creatorId: '1')
              ]),
      Future.delayed(
          Duration(seconds: 4),
          () => [
                Chat(participents: [
                  '1',
                  '3'
                ], lastMessageTime: DateTime.now(), creationTime: DateTime.now(), creatorId: '3')
              ]),
    ]);
  }
}
