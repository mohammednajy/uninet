
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/feature/home/repo/home_repository.dart';

final showAllPosts = StreamProvider.autoDispose((ref) {
  return ref.read(homeRepositoryProvider).showPosts();
},);