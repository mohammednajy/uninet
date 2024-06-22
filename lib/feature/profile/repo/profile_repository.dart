import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';

class ProfileRepository {
  ProfileRepository({required this.ref});

  Ref ref;

  Future<Either<String, bool>> uploadProfileData(
      {required Map<String, dynamic> userData}) async {
    try {
      final userID = ref.read(firebaseAuthProvider).currentUser?.uid;
      if (userID != null) {
        final user = await ref
            .read(firebaseFireStoreProvider)
            .collection('users')
            .where('userId', isEqualTo: userID)
            .get();
        if (user.docs.isNotEmpty) {
          await user.docs.single.reference.update(userData);
          return right(true);
        } else {
          return left('User not found');
        }
      } else {
        return left('User not logged in');
      }
    } on FirebaseException catch (e) {
      return left(e.code);
    }
  }
}

final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) => ProfileRepository(ref: ref));
