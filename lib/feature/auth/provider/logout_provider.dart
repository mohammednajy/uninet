import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repo/auth_repo.dart';

class LogoutProvider extends AutoDisposeAsyncNotifier<bool> {
  @override
  bool build() => false;

  void logout() async {
    state = const AsyncLoading();
    final response = await ref.read(authRepoProvider).logout();
    state = response.fold((left) => AsyncError(left, StackTrace.current),
        (right) => AsyncData(right));
  }
}

final logoutProvider = AsyncNotifierProvider.autoDispose<LogoutProvider, bool>(
    () => LogoutProvider());
