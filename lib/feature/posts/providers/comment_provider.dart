import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/feature/home/repo/home_repository.dart';
import 'package:uninet/feature/posts/model/post_model.dart';

class SendComment extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() => false;

  void sendNewComment(
      {required Comment comment, required String postId}) async {
    state = const AsyncLoading();
    final response = await ref
        .read(homeRepositoryProvider)
        .sendComment(comment: comment, postId: postId);
    response.fold((left) {
      state = AsyncError(left, StackTrace.current);
    }, (right) {
      state = AsyncData(right);
    });
  }
}

final sendCommentProvider =
    AsyncNotifierProvider.autoDispose<SendComment, bool>(() => SendComment());

final showAllComments = StreamProvider.autoDispose.family<List<Comment>, String>(
  (ref, postId) {
    return ref.read(homeRepositoryProvider).showComments(postId);
  },
);
