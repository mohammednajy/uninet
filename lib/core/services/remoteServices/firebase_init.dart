import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:uninet/core/services/localServices/sherd_perf_manager.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<SharedPrefController>(
      () => SharedPrefController());
  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseService(),
  );
}

class FirebaseService {
  late final FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  FirebaseService() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }
}
