// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LikesModel {
  final List<UserLikes> fromYou;
  final List<UserLikes> fromOthers;
  LikesModel({
    required this.fromYou,
    required this.fromOthers,
  });

  LikesModel copyWith({
    List<UserLikes>? fromYou,
    List<UserLikes>? fromOthers,
  }) {
    return LikesModel(
      fromYou: fromYou ?? this.fromYou,
      fromOthers: fromOthers ?? this.fromOthers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromYou': fromYou.map((x) => x.toMap()).toList(),
      'fromOthers': fromOthers.map((x) => x.toMap()).toList(),
    };
  }

  factory LikesModel.fromMap(Map<String, dynamic> map) {
    return LikesModel(
      fromYou: List<UserLikes>.from(
        (map['fromYou'] as List<int>).map<UserLikes>(
          (x) => UserLikes.fromMap(x as Map<String, dynamic>),
        ),
      ),
      fromOthers: List<UserLikes>.from(
        (map['fromOthers'] as List<int>).map<UserLikes>(
          (x) => UserLikes.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LikesModel.fromJson(String source) => LikesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LikesModel(fromYou: $fromYou, fromOthers: $fromOthers)';

  @override
  bool operator ==(covariant LikesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.fromYou, fromYou) && listEquals(other.fromOthers, fromOthers);
  }

  @override
  int get hashCode => fromYou.hashCode ^ fromOthers.hashCode;
}

class UserLikes {
  final String userId;
  final DateTime likedDate;
  UserLikes({
    required this.userId,
    required this.likedDate,
  });

  UserLikes copyWith({
    String? userId,
    DateTime? likedDate,
  }) {
    return UserLikes(
      userId: userId ?? this.userId,
      likedDate: likedDate ?? this.likedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'likedDate': likedDate.millisecondsSinceEpoch,
    };
  }

  factory UserLikes.fromMap(Map<String, dynamic> map) {
    return UserLikes(
      userId: map['userId'] as String,
      likedDate: DateTime.fromMillisecondsSinceEpoch(map['likedDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLikes.fromJson(String source) => UserLikes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserLikes(userId: $userId, likedDate: $likedDate)';

  @override
  bool operator ==(covariant UserLikes other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.likedDate == likedDate;
  }

  @override
  int get hashCode => userId.hashCode ^ likedDate.hashCode;
}
