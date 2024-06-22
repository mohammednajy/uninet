// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uninet/core/services/remoteServices/firebase_init.dart';

class VerificationRepository {
  final Ref ref;
  VerificationRepository({
    required this.ref,
  });
  final picker = ImagePicker();
  Future<Either<String, File>> pickImage({required ImageSource source}) async {
    try {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        return right(File(pickedImage.path));
      }
      return left('Something went wrong, try again');
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left('Something went wrong, try again');
    }
  }

  Future<Either<String, String>> uploadImageToStorage(
      {required File image,required String imageSide,required String folderName}) async {
    try {
      var imageName = ref.read(firebaseAuthProvider).currentUser!.uid;
      var storageRef = ref
          .read(firebaseStorageProvider)
          .ref()
          .child('$folderName/$imageSide$imageName.png');
      var uploadTask = storageRef.putFile(image);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return right(downloadUrl);
    } on FirebaseException catch (e) {
      return left(e.code);
    } catch (e) {
      return left('something went wrong during the uploading, try again');
    }
  }
}

final verificationRepositoryProvider =
    Provider<VerificationRepository>((ref) => VerificationRepository(ref: ref));
