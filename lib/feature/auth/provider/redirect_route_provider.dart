// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/core/services/localServices/sherd_perf_manager.dart';
import 'package:uninet/core/utils/extensions.dart';

class RedirectRoute {
  Ref ref;
  RedirectRoute({
    required this.ref,
  });

  SharedPreferencesService get sharedPref =>
      ref.watch(sharedPreferencesProvider).requireValue;

  setVerificationProgress({bool value = true}) async {
    await sharedPref.saveBool(PrefKeys.isVerificationDone.toString(), value);
  }

  bool getVerificationProgress() {
    return sharedPref.getBool(PrefKeys.isVerificationDone.toString()) ?? false;
  }

  setProfileProgress({bool value = true}) async {
    await sharedPref.saveBool(PrefKeys.isCompleteProfileDone.toString(), value);
  }

  bool getProfileProgress() {
    return sharedPref.getBool(PrefKeys.isCompleteProfileDone.toString()) ??
        false;
  }

  // setVerificationAppear() async {
  //   await sharedPref.saveBool(PrefKeys.isVerificationAppear.toString(), true);
  // }

  // getVerificationAppear() {
  //   return sharedPref.getBool(PrefKeys.isVerificationAppear.toString()) ??
  //       false;
  // }
}

final redirectRouteProvider = Provider((ref) => RedirectRoute(ref: ref));
