import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uninet/feature/auth/controller/auth_controller.dart';
import 'package:uninet/feature/auth/screen/auth_screen.dart';
import 'package:uninet/feature/auth/screen/code_otp_screen.dart';
import 'package:uninet/feature/auth/screen/reset_password_screen.dart';
import 'package:uninet/feature/mainApp/screens/main_app_screen.dart';
import 'package:uninet/feature/profile/screens/complete_profile_screen.dart';
import 'package:uninet/feature/verification/screens/verification_screen.dart';
import 'package:uninet/router/routes_name.dart';

import '../feature/auth/screen/new_password_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.authRoute:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => AuthController(),
          child: const AuthScreen(),
        ),
      );
    case RouteName.resetPasswordRoute:
      return MaterialPageRoute(
        builder: (context) => const RestPasswordScreen(),
      );
    case RouteName.codeOtpScreen:
      return MaterialPageRoute(
        builder: (context) => const CodeOtpScreen(),
      );
    case RouteName.newPasswordScreen:
      return MaterialPageRoute(
        builder: (context) => const NewPasswordScreen(),
      );
    case RouteName.mainAppScreen:
      return MaterialPageRoute(
        builder: (context) => const MainAppScreen(),
      );

    case RouteName.verificationScreen:
      return MaterialPageRoute(
        builder: (context) => const VerificationScreen(),
      );
    case RouteName.completeProfileScreen:
      return MaterialPageRoute(
        builder: (context) => const CompleteProfileScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Text('wrong path'),
      );
  }
}
