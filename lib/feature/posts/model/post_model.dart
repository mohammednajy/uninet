// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uninet/feature/auth/models/user_model.dart';

class Post {
  final UserModel userModel;
  final List<String>? images;
  final String? description;
  final String? chasingCategory;
  final int likes;
  final int retweet;
  final List<Comment> comment;

  Post(
      {required this.userModel,
      this.images,
      this.description,
      this.chasingCategory,
      required this.likes,
      required this.retweet,
      required this.comment});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userModel': userModel.toMapPost(),
      'images': images,
      'description': description,
      'chasingCategory': chasingCategory,
      'likes': likes,
      'retweet': retweet,
      'comment': comment.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userModel: UserModel.fromMap(map['userModel'] as Map<String, dynamic>),
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      chasingCategory: map['chasingCategory'] != null
          ? map['chasingCategory'] as String
          : null,
      likes: map['likes'] as int,
      retweet: map['retweet'] as int,
      comment: List<Comment>.from(
        (map['comment'] as List<int>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  Post copyWith({
    UserModel? userModel,
    List<String>? images,
    String? description,
    String? chasingCategory,
    int? likes,
    int? retweet,
    List<Comment>? comment,
  }) {
    return Post(
        userModel: userModel ?? this.userModel,
        likes: likes ?? this.likes,
        retweet: retweet ?? this.retweet,
        comment: comment ?? this.comment,
        images: images ?? this.images,
        description: description ?? this.description,
        chasingCategory: chasingCategory ?? this.chasingCategory);
  }

  @override
  String toString() {
    return 'Post(userModel: $userModel, images: $images, description: $description, chasingCategory: $chasingCategory, likes: $likes, retweet: $retweet, comment: $comment)';
  }
}

class Comment {
  final String details;
  final UserModel user;

  Comment({required this.details, required this.user});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'details': details,
      'user': user.toMapPost(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      details: map['details'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
