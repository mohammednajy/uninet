import 'package:firebase_core/firebase_core.dart';

class FireStoreException {
  static String handlingFireStoreException(FirebaseException e) {
    String message = '';
    switch (e.code) {
      case 'permission-denied':
        message = 'You do not have permission to access this resource.';
        break;
      case 'unavailable':
        message =
            'The service is currently unavailable. Please try again later.';
        break;
      case 'deadline-exceeded':
        message =
            'The request took too long to complete. Please try again later.';
        break;
      case 'not-found':
        message = 'The requested resource was not found.';
        break;
      case 'already-exists':
        message = 'The resource you are trying to create already exists.';
        break;
      case 'cancelled':
        message = 'The operation was cancelled.';
        break;
      case 'resource-exhausted':
        message = 'You have exceeded your resource quota.';
        break;
      case 'failed-precondition':
        message = 'The operation was aborted due to a failed precondition.';
        break;
      case 'aborted':
        message = 'The operation was aborted due to a conflict.';
        break;
      case 'out-of-range':
        message = 'The request is out of range.';
        break;
      case 'internal':
        message = 'An internal error occurred. Please try again later.';
        break;
      case 'unauthenticated':
        message = 'You are not authenticated. Please log in and try again.';
        break;
      default:
        message = 'An undefined error occurred: ${e.message}';
    }
    return message;
  }
}
