import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final firebaseFireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final sharedPref =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());