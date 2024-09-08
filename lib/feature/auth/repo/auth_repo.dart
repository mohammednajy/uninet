import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/services/localServices/sherd_perf_manager.dart';
import '../../../core/services/remoteServices/firebase_init.dart';
import '../../../core/utils/auth_exception.dart';
import '../../../core/utils/extensions.dart';
import '../models/user_model.dart';

class sharedPreference {
  final Ref ref;

  sharedPreference({required this.ref});

  Future<Either<String, User>> login(
      {required String email, required String password}) async {
    try {
      final credential = await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        final userModel = UserModel(
          email: email,
          userId: credential.user!.uid,
          image: credential.user?.photoURL,
          displayName: credential.user?.displayName,
          name: credential.user?.displayName,
        );
        saveUser(userModel);
        return right(credential.user!);
      }
      return left('unexpected error occurred, try agin');
    } on FirebaseAuthException catch (e) {
      return left(AuthException.handleLoginException(e));
    } catch (e) {
      return left('Something went wrong');
    }
  }

  Future<Either<String, User>> singUp(
      {required String email, required String password}) async {
    try {
      final credential =
          await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      print(credential.user);
      if (credential.user != null) {
        final value = await createAccount(user: credential.user!);

        if (value) {
          return right(credential.user!);
        } else {
          return left('Something went wrong, try again');
        }
      }
      return left('unexpected error occurred, try agin');
    } on FirebaseAuthException catch (e) {
      return left(AuthException.handleRegisterException(e));
    } catch (e) {
      return left('Something went wrong, try again');
    }
  }

  Future<Either<String, User>> singUpWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        if (userCredential.user != null) {
          final value = await createAccount(user: userCredential.user!);
          if (value) {
            return right(userCredential.user!);
          } else {
            return left('Something went wrong, try again');
          }
        }
      } else {
        return left('Facebook sign-in Canceled');
      }
      return left('unexpected error occurred, try agin');
    } on FirebaseAuthException catch (e) {
      return left(AuthException.handleRegisterException(e));
    } catch (e) {
      return left('Error during Facebook sign-in');
    }
  }

  Future<Either<String, User>> singUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return left('Google sign-in Canceled');
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        final value = await createAccount(user: userCredential.user!);
        if (value) {
          return right(userCredential.user!);
        } else {
          return left('Something went wrong, try again');
        }
      }
      return left('unexpected error occurred, try agin');
    } on FirebaseAuthException catch (e) {
      return left(AuthException.handleRegisterException(e));
    } catch (e) {
      return left('Error during google sign-in');
    }
  }

  Future<Either<String, bool>> sendResetPassword(
      {required String email}) async {
    try {
      await ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
      return right(true);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.handleLoginException(e));
    } catch (e) {
      return left('Something went wrong, try agin');
    }
  }

  Future<bool> createAccount({
    required User user,
  }) async {
    try {
      final userModel = UserModel(
        email: user.email!,
        userId: user.uid,
        image: user.photoURL,
        displayName: user.displayName,
        name: user.displayName,
      );

      await ref
          .read(firebaseFireStoreProvider)
          .collection('users')
          .add(userModel.toMap());
      saveUser(userModel);
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      await ref.read(firebaseAuthProvider).signOut();
      await removeUser();

      // await GoogleSignIn().disconnect();
      return right(true);
    } on FirebaseException catch (e) {
      return left(e.code);
    } catch (e) {
      return left('something went wrong try agin');
    }
  }

  Future<UserModel> getRemoteUserData() async {
    try {
      final userId = ref.read(firebaseAuthProvider).currentUser!.uid;
      final value = await ref
          .read(firebaseFireStoreProvider)
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();
      return UserModel.fromMap(value.docs.single.data());
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

// this is for saving the user local inside sharedPreferance and used to mange the routes.
  saveUser(UserModel user) {
    final sharedPref = ref.watch(sharedPreferencesProvider).requireValue;
    sharedPref.saveString(PrefKeys.user.toString(), user.toJson());
  }

  UserModel? getUser() {
    final sharedPref = ref.watch(sharedPreferencesProvider).requireValue;
    final jsonUser = sharedPref.getString(PrefKeys.user.toString());
    return jsonUser != null ? UserModel.fromJson(jsonUser) : null;
  }

  removeUser() async {
    final sharedPref = ref.watch(sharedPreferencesProvider).requireValue;
    await sharedPref.removeString(PrefKeys.user.toString());
  }
}

final authRepoProvider =
    Provider<sharedPreference>((ref) => sharedPreference(ref: ref));

final authIndexRoute = StateProvider<int>((ref) => 0);
