import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repo/auth_repo.dart';

class LoginProvider extends AutoDisposeAsyncNotifier<User?> {
  @override
  User? build() => null;

  void login({required String email, required String password}) async {
    state = const AsyncLoading();
    final response = await ref
        .read(authRepoProvider)
        .login(email: email, password: password);
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final loginProvider = AsyncNotifierProvider.autoDispose<LoginProvider, User?>(
    () => LoginProvider());




