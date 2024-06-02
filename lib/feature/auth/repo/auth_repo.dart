import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/core/utils/auth_exception.dart';
import 'package:uninet/feature/auth/models/user_model.dart';

class AuthRepository {
  final Ref ref;

  AuthRepository({required this.ref});

  Future<Either<String, User>> login(
      {required String email, required String password}) async {
    try {
      final credential = await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
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
          await getIt<FirebaseService>().auth.createUserWithEmailAndPassword(
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
      await getIt<FirebaseService>().auth.sendPasswordResetEmail(email: email);
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
      await getIt<FirebaseService>()
          .firestore
          .collection('users')
          .add(UserModel(
            email: user.email!,
            userId: user.uid,
            image: user.photoURL,
            displayName: user.displayName,
            name: user.displayName,
          ).toMap());
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }
}

final authRepoProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref: ref));

final authIndexRoute = StateProvider<int>((ref) => 0);
