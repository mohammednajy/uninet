import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';

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




// this is another solution  
// class LoginProvider extends Notifier<FirebaseResponse<User>> {
//   @override
//   FirebaseResponse<User> build() => FirebaseResponse.init();

//   void login({required String email, required String password}) async {
//     state = FirebaseResponse.loading('loading');
//     final response = await ref
//         .read(authRepoProvider)
//         .login(email: email, password: password);

//     state = response.fold((message) => FirebaseResponse.error(message),
//         (user) => FirebaseResponse.completed(user));
//   }
// }

// final loginProvider = NotifierProvider<LoginProvider, FirebaseResponse<User>>(
//     () => LoginProvider());