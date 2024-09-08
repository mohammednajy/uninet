import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repo/auth_repo.dart';

class ResetPasswordProvider extends AutoDisposeAsyncNotifier<bool?> {
  @override
  bool? build() => null;

  void sendResetPassword({required String email}) async {
    state = const AsyncLoading();
    final response = await ref
        .read(authRepoProvider)
        .sendResetPassword(email: email);
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final resetPasswordProvider = AsyncNotifierProvider.autoDispose<ResetPasswordProvider, bool?>(
    () => ResetPasswordProvider());