import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../repo/profile_repository.dart';

import '../../verification/repo/verification_repository.dart';

class CompleteProfile extends AutoDisposeAsyncNotifier<bool?> {
  @override
  FutureOr<bool?> build() => null;

  uploadUserData(Map<String, dynamic> user) async {
    state = const AsyncLoading();
    final output = await ref
        .read(profileRepositoryProvider)
        .uploadProfileData(userData: user);
    state = output.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final completeProfileProvider =
    AsyncNotifierProvider.autoDispose<CompleteProfile, bool?>(
  () => CompleteProfile(),
);

class PickImageProfile extends AutoDisposeAsyncNotifier<File?> {
  @override
  File? build() => null;

  pickImageFromBack({required ImageSource source}) async {
    state = const AsyncLoading();
    final output = await ref
        .read(verificationRepositoryProvider)
        .pickImage(source: source);
    state = output.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final pickImageProfileProvider =
    AsyncNotifierProvider.autoDispose<PickImageProfile, File?>(
  () => PickImageProfile(),
);

class ProfileUploadImage extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() => null;

  uploadImage({required File image}) async {
    state = const AsyncLoading();

    final response = await ref
        .read(verificationRepositoryProvider)
        .uploadImageToStorage(
            image: image, imageSide: 'front', folderName: 'profileImages');

    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final profileUploadImageProvider =
    AsyncNotifierProvider.autoDispose<ProfileUploadImage, String?>(
  () => ProfileUploadImage(),
);
