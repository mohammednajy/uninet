import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uninet/core/router/route.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/core/utils/theme_manager.dart';

import 'firebase_options.dart';

// final vlaue = FirebaseAuth.instance.authStateChanges();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const ProviderScope(child: UniNet()));
  FlutterNativeSplash.remove();
}

class UniNet extends StatelessWidget {
  const UniNet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: RouteName.mainAppScreen,
      theme: ThemeManager.lightTheme,
    );
  }
}
