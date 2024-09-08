import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';

final userDataProvider = FutureProvider((ref) async {
  return await ref.read(authRepoProvider).getRemoteUserData();
});
