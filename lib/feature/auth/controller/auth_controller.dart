import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/core/utils/auth_exception.dart';
import 'package:uninet/feature/auth/models/user_model.dart';
import 'package:uninet/feature/widgets/loading_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/snackbar_widget.dart';

class AuthController extends ChangeNotifier {
  // login controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

// singUp controller

  TextEditingController emailControllerSingUp = TextEditingController();
  TextEditingController passwordControllerSingUp = TextEditingController();
  int pageIndex = 0;

  clickToNavigate(int index) {
    pageIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void singUp() async {
    loadingWithText();
    try {
      final credential =
          await getIt<FirebaseService>().auth.createUserWithEmailAndPassword(
                email: emailControllerSingUp.text,
                password: passwordControllerSingUp.text,
              );
      print(credential.user);
      if (credential.user != null) {
        createAccount(user: credential.user!);
      }
    } on FirebaseAuthException catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: AuthException.handleRegisterException(e));
    } catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  void singInWithFacebook() async {
    loadingWithText();
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        final value = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        if (value.user != null) {
          createAccount(user: value.user!, navigationAction: false);
        }
      } else {
        RouteManager.pop();
        showSnackBarCustom(text: 'Facebook sign-in Canceled');
      }
    } on FirebaseAuthException catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: AuthException.handleRegisterException(e));
    } catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: 'Error during Facebook sign-in');
    }
  }

  Future<void> login() async {
    loadingWithText();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (credential.user != null) {
        RouteManager.goToAndRemove(RouteName.verificationScreen);
      }
    } on FirebaseAuthException catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: AuthException.handleLoginException(e));
    } catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: 'Something went wrong');
    }
  }

  Future<void> signInWithGoogle() async {
    loadingWithText();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        RouteManager.pop();
        showSnackBarCustom(text: 'Google sign-in Canceled');
        return;
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final value =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (value.user != null) {
        createAccount(user: value.user!, navigationAction: false);
      }
    } on FirebaseAuthException catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: AuthException.handleRegisterException(e));
    } catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: 'Error during google sign-in');
    }
  }

  void createAccount({
    required User user,
    bool navigationAction = true,
  }) async {
    await getIt<FirebaseService>()
        .firestore
        .collection('users')
        .add(UserModel(
          email: user.email!,
          userId: user.uid,
          image: user.photoURL,
          displayName: user.displayName,
          name: user.displayName,
        ).toMap())
        .whenComplete(() {
      RouteManager.pop();
      navigationAction
          ? clickToNavigate(0)
          : RouteManager.goToAndRemove(RouteName.mainAppScreen);
    }).catchError((error, stackTrace) => print(error));
  }

  void sendRestPasswordEmail({required String email}) async {
    loadingWithText();
    try {
      await getIt<FirebaseService>().auth.sendPasswordResetEmail(email: email);
      RouteManager.pop();
      showSnackBarCustom(
          text: 'Email send successfully, check you email',
          backgroundColor: Colors.green);
      RouteManager.pushNamed(RouteName.resetPasswordInfoScreen);
    } on FirebaseAuthException catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: AuthException.handleLoginException(e));
    } catch (e) {
      RouteManager.pop();
      showSnackBarCustom(text: 'Something went wrong, try agin');
    }
  }
}
