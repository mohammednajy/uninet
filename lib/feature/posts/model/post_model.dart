// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uninet/feature/auth/models/user_model.dart';

class Post {
  final UserModel userModel;
  final String? postId;
  final List<String>? images;
  final String? description;
  final String? chasingCategory;
  final List<String> likes;
  final List<String> retweet;
  final List<Comment> comment;
  final Timestamp timeStamp;

  Post({
    required this.userModel,
    this.postId,
    this.images,
    this.description,
    this.chasingCategory,
    required this.likes,
    required this.retweet,
    required this.comment,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userModel': userModel.toMapPost(),
      'images': images,
      'description': description,
      'chasingCategory': chasingCategory,
      'likes': likes,
      'retweet': retweet,
      'timeStamp': timeStamp,
      'comment': comment.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMapSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return Post(
      userModel: UserModel.fromPostMap(
          map.data()['userModel'] as Map<String, dynamic>),
      images: map.data()['images'] != null
          ? List<String>.from((map.data()['images']))
          : null,
      description: map.data()['description'] != null
          ? map.data()['description'] as String
          : null,
      chasingCategory: map.data()['chasingCategory'] != null
          ? map.data()['chasingCategory'] as String
          : null,
      likes: List<String>.from((map.data()['likes'])),
      timeStamp: map.data()['timeStamp'],
      postId: map.id,
      retweet: List<String>.from((map.data()['retweet'])),
      comment: List<Comment>.from(
        (map.data()['comment'] as List).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  // factory Post.fromJson(String source) =>
  //     Post.fromJson(json.decode(source) as Map<String, dynamic>);

  Post copyWith(
      {UserModel? userModel,
      List<String>? images,
      String? description,
      String? chasingCategory,
      List<String>? likes,
      List<String>? retweet,
      List<Comment>? comment,
      String? postId,
      Timestamp? timeStamp}) {
    return Post(
        userModel: userModel ?? this.userModel,
        postId: postId ?? this.postId,
        likes: likes ?? this.likes,
        retweet: retweet ?? this.retweet,
        comment: comment ?? this.comment,
        images: images ?? this.images,
        description: description ?? this.description,
        chasingCategory: chasingCategory ?? this.chasingCategory,
        timeStamp: timeStamp ?? this.timeStamp);
  }

  @override
  String toString() {
    return 'Post(userModel: $userModel, images: $images, description: $description, chasingCategory: $chasingCategory, likes: $likes, retweet: $retweet, comment: $comment)';
  }
}

class Comment {
  final String details;
  final UserModel user;
  final Timestamp timestamp;

  Comment({required this.details, required this.user, required this.timestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'details': details,
      'user': user.toMapPost(),
      'timestamp': timestamp
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        details: map['details'] as String,
        user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
        timestamp: map['timestamp']);
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Comment(details: $details, user: $user, timestamp: $timestamp)';
}
