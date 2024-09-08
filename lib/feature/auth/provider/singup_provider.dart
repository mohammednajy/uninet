import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repo/auth_repo.dart';

class SingUpProvider extends AutoDisposeAsyncNotifier<User?> {
  @override
  User? build() => null;

  void singUp({required String email, required String password}) async {
    state = const AsyncLoading();
    final response = await ref
        .read(authRepoProvider)
        .singUp(email: email, password: password);
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }

  void singUpWithFacebook() async {
    state = const AsyncLoading();
    final response = await ref.read(authRepoProvider).singUpWithFacebook();
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }

  void singUpWithGoogle() async {
    state = const AsyncLoading();
    final response = await ref.read(authRepoProvider).singUpWithGoogle();
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final singUpProvider = AsyncNotifierProvider.autoDispose<SingUpProvider, User?>(
    () => SingUpProvider());

final checkboxValueProvider = StateProvider<bool>((ref) => false);
