import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uninet/feature/verification/repo/verification_repository.dart';

// class PickImageFront extends AutoDisposeAsyncNotifier<File?> {
//   @override
//   File? build() => null;

//   pickImageFromFront({required ImageSource source}) async {
//     state = const AsyncLoading();
//     final output = await ref
//         .read(verificationRepositoryProvider)
//         .pickImage(source: source);
//     state = output.fold((left) => AsyncError(left, StackTrace.current),
//         (right) => AsyncData(right));
//   }
// }

// class PickImageBack extends AutoDisposeAsyncNotifier<File?> {
//   @override
//   File? build() => null;

//   pickImageFromBack({required ImageSource source}) async {
//     state = const AsyncLoading();
//     final output = await ref
//         .read(verificationRepositoryProvider)
//         .pickImage(source: source);
//     state = output.fold((left) => AsyncError(left, StackTrace.current),
//         (right) => AsyncData(right));
//   }
// }

class PickImage extends AutoDisposeAsyncNotifier<Map<String, File?>> {
  @override
  Map<String, File?> build() => {"front": null, "back": null};

  pickImageFromBack(
      {required ImageSource source, required String pickedSide}) async {
    state = const AsyncLoading();
    final output = await ref
        .read(verificationRepositoryProvider)
        .pickImage(source: source);
    state = output.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData({...?state.value, pickedSide: right}));
  }
}

class UploadImage extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() => null;

  uploadImage({required File image, required String imageSide}) async {
    state = const AsyncLoading();

    final response = await ref
        .read(verificationRepositoryProvider)
        .uploadImageToStorage(
            image: image,
            imageSide: imageSide,
            folderName: 'verificationDocuments');

    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

// final pickImageFrontProvider =
//     AsyncNotifierProvider.autoDispose<PickImageFront, File?>(
//         () => PickImageFront());

// final pickImageBackProvider =
//     AsyncNotifierProvider.autoDispose<PickImageBack, File?>(
//         () => PickImageBack());

final pickImageProvider =
    AsyncNotifierProvider.autoDispose<PickImage, Map<String, File?>>(
        () => PickImage());
final uploadImageProvider =
    AsyncNotifierProvider.autoDispose<UploadImage, String?>(
        () => UploadImage());
