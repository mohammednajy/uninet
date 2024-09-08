import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/remoteServices/firebase_init.dart';
import '../../../core/utils/firestore_exception.dart';
import '../model/post_model.dart';

class PostRepository {
  Ref ref;
  PostRepository({
    required this.ref,
  });
  final picker = ImagePicker();
  Future<List<dynamic>> suggestionImages() async {
    try {
      final response = await ref
          .read(firebaseFireStoreProvider)
          .collection('postsPhoto')
          .doc('SqPdMGNe8P1yFQEsx1wO')
          .get();
      return response.get('images');
    } on FirebaseException catch (e) {
      print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
      print(e.code);
      throw FireStoreException.handlingFireStoreException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, List<File>>> pickImages() async {
    try {
      final pickedImage = await picker.pickMultiImage();
      if (pickedImage.isNotEmpty) {
        return right(pickedImage.map((e) => File(e.path)).toList());
      }
      return left('Something went wrong, try again');
    } on Exception catch (e) {
      print('-----------------------------------');
      print(e);
      debugPrint(e.toString());
      return left('Something went wrong, try again');
    }
  }

  Future<Either<String, bool>> createNewPost({required Post post}) async {
    try {
      await ref
          .read(firebaseFireStoreProvider)
          .collection('posts')
          .add(post.toMap());
      return right(true);
    } on FirebaseException catch (e) {
      print('================================');
      print(e.code);
      return left(FireStoreException.handlingFireStoreException(e));
    }
  }

  Future<Either<String, String>> uploadFile(File image) async {
    try {
      final userId = ref.read(firebaseAuthProvider).currentUser?.uid;
      final value = await ref
          .read(firebaseStorageProvider)
          .ref()
          .child(
              'posts/${userId}-${Random().nextInt(100) * Random().nextInt(100)}')
          .putFile(image);
      return right(await value.ref.getDownloadURL());
    } on FirebaseException catch (e) {
      print('1111111111111111111111111111111');
      print(e.code);
      return left(FireStoreException.handlingFireStoreException(e));
    }
  }
}

final postRepositoryProvider = Provider((ref) => PostRepository(ref: ref));
