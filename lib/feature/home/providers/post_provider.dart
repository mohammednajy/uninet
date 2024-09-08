import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repo/home_repository.dart';

final showAllPosts = StreamProvider.autoDispose(
  (ref) {
    return ref.read(homeRepositoryProvider).showPosts();
  },
);

final removeLikeProvider =
    FutureProvider.family<bool, String>((ref, postId) async {
  return await ref.read(homeRepositoryProvider).removeLike(postId: postId);
});

final addLikeProvider =
    FutureProvider.family<bool, String>((ref, postId) async {
  return await ref.read(homeRepositoryProvider).setLike(postId: postId);
});
