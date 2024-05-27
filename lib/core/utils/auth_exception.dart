import 'package:firebase_auth/firebase_auth.dart';

class AuthException {
  static String handleRegisterException(FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'weak-password':
        errorMessage = 'Weak password, please use strong password';
        break;
      case 'email-already-in-use':
        errorMessage = 'This email already uses, please use another one';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error , check you internet connection';
        break;
      default:
        errorMessage = 'Something went wrong, try agin';
    }
    return errorMessage;
  }

  static String handleLoginException(FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'Wrong email, enter correct one';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email';
        break;
      case 'too-many-requests':
        errorMessage = 'too many requests of trying login';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error , check you internet connection';
        break;
      case 'user-token-expired':
        errorMessage = 'user token expired';
        break;
      default:
        errorMessage = 'Something went wrong, try agin';
    }
    return errorMessage;
  }

  static String handleResetPasswordException(FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'Wrong email, enter correct one';
        break;
      case 'invalid-email':
        errorMessage = 'Enter valid email';
        break;
      case 'too-many-requests':
        errorMessage = 'too many requests of trying reset password';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error , check you internet connection';
        break;
      default:
        errorMessage = 'Something went wrong, try agin';
    }
    return errorMessage;
  }
}
