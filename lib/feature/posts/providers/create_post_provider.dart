import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/feature/posts/model/post_model.dart';
import 'package:uninet/feature/posts/repo/post_repository.dart';
import 'package:uninet/feature/verification/providers/verification_provider.dart';

final suggestionImagesPostProvider = FutureProvider.autoDispose((ref) {
  return ref.read(postRepositoryProvider).suggestionImages();
});

class PickImages extends AutoDisposeAsyncNotifier<List<Image>> {
  @override
  List<Image> build() => [];

  void pickImages() async {
    state = const AsyncLoading();
    final output = await ref.read(postRepositoryProvider).pickImages();
    state = output.fold(
        (left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(
            [...state.value!, ...right.map((e) => Image.file(e)).toList()]));
  }

  void removeImage(int index) {
    final newImages = state.value;
    newImages!.removeAt(index);
    state = AsyncData(newImages);
  }

  void addImage(Image image) {
    state = AsyncData([...state.value!, image]);
  }
}

final pickImagesProvider =
    AsyncNotifierProvider.autoDispose<PickImages, List<Image>>(
        () => PickImages());

class CreateNewPost extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() => false;

  createNewPost(Post post) async {
    state = const AsyncLoading();

    // this code for uploading and get the images urls
    final images = ref.watch(pickImagesProvider).value;
    final List<String> imagesURL = [];
    if (images != null && images.isNotEmpty) {
      for (Image e in images) {
        if (e.image is FileImage) {
          FileImage image = e.image as FileImage;
          final value = await ref
              .read(postRepositoryProvider)
              .uploadFile(image.file)
              .then((e) {
            e.fold((left) {
              state = AsyncError(left, StackTrace.current);
            }, (right) {
              imagesURL.add(right);
            });
          });
        } else if (e.image is NetworkImage) {
          NetworkImage image = e.image as NetworkImage;
          imagesURL.add(image.url);
        }
      }
    }

// this for store the post inside the fireStore
    final response = await ref
        .read(postRepositoryProvider)
        .createNewPost(post: post.copyWith(images: imagesURL));
    response.fold((left) {
      state = AsyncError(left, StackTrace.current);
    }, (right) {
      state = AsyncData(right);
    });
  }
}

final createNewPostProvider =
    AsyncNotifierProvider.autoDispose<CreateNewPost, bool>(
        () => CreateNewPost());
