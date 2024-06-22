import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:uninet/core/services/localServices/sherd_perf_manager.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<SharedPrefController>(
      () => SharedPrefController());
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final firebaseFireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
