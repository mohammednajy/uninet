import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';
import '../../../core/services/remoteServices/firebase_init.dart';
import '../../../core/utils/firestore_exception.dart';
import '../../posts/model/post_model.dart';

class HomeRepository {
  Ref ref;
  HomeRepository({
    required this.ref,
  });

  Stream<List<Post>> showPosts() async* {
    try {
      final value = ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Post.fromMapSnapshot(doc)).toList();
      });
      yield* value;
    } on FirebaseException catch (e) {
      throw FireStoreException.handlingFireStoreException(e);
    }
  }

  Future<bool> setLike({
    required String postId,
  }) async {
    try {
      await ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .doc(postId)
          .update({
        'likes': FieldValue.arrayUnion(
            [ref.read(authRepoProvider).getUser()!.userId])
      });
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      return false;
    }
  }

  Future<bool> removeLike({
    required String postId,
  }) async {
    try {
      await ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .doc(postId)
          .update({
        'likes': FieldValue.arrayRemove(
            [ref.read(authRepoProvider).getUser()!.userId])
      });
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      print(e.code);
      return false;
    }
  }

  Future<Either<String, bool>> sendComment(
      {required Comment comment, required String postId}) async {
    try {
      await ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .doc(postId)
          .update({
        'comment': FieldValue.arrayUnion([comment.toMap()])
      });
      return right(true);
    } on FirebaseException catch (e) {
      return left(FireStoreException.handlingFireStoreException(e));
    }
  }

  Stream<List<Comment>> showComments(String postId) async* {
    try {
      yield* ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .doc(postId)
          .snapshots()
          .map((snapshot) {
        final data = snapshot.data();
        if (data == null) return [];
        final comments = data['comment'] as List<dynamic>;
        return comments
            .map((commentData) =>
                Comment.fromMap(commentData as Map<String, dynamic>))
            .toList()
            .reversed
            .toList();
      });
    } on FirebaseException catch (e) {
      throw FireStoreException.handlingFireStoreException(e);
    }
  }
}

final homeRepositoryProvider = Provider((ref) => HomeRepository(ref: ref));
