import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/core/utils/firestore_exception.dart';
import 'package:uninet/feature/posts/model/post_model.dart';

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
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
      });
      yield* value;
    } on FirebaseException catch (e) {
      throw FireStoreException.handlingFireStoreException(e);
    }
  }
}

final homeRepositoryProvider = Provider((ref) => HomeRepository(ref: ref));
