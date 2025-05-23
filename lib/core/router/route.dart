import 'package:flutter/material.dart';
import 'routes_name.dart';
import '../../feature/auth/screen/auth_screen.dart';
import '../../feature/auth/screen/code_otp_screen.dart';
import '../../feature/auth/screen/new_password_screen.dart';
import '../../feature/auth/screen/reset_password_screen.dart';
import '../../feature/auth/screen/reset_passwrod_info_screen.dart';
import '../../feature/mainApp/screens/main_app_screen.dart';
import '../../feature/posts/screens/create_new_post_screen.dart';
import '../../feature/profile/screens/complete_profile_screen.dart';
import '../../feature/settings/screens/settings_screen.dart';
import '../../feature/verification/screens/verification_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.authRoute:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
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
    case RouteName.createNewPostScreen:
      return MaterialPageRoute(
        builder: (context) => const CreateNewPostScreen(),
      );
    case RouteName.resetPasswordInfoScreen:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordInfoScreen(),
      );
    case RouteName.settingsScreen:
      return MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Text('wrong path'),
      );
  }
}
