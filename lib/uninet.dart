import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/router/route.dart';
import 'core/router/routes_name.dart';
import 'core/router/routing.dart';
import 'core/utils/theme_manager.dart';
import 'feature/auth/repo/auth_repo.dart';

class UniNet extends HookConsumerWidget {
  const UniNet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: RouteManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: ref.read(authRepoProvider).getUser() == null
          ? RouteName.authRoute
          : RouteName.mainAppScreen,
      theme: ThemeManager.lightTheme,
    );
  }
}
