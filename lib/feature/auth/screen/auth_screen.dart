import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';
import 'package:uninet/feature/auth/screen/login_screen.dart';
import 'package:uninet/feature/auth/screen/signup_screen.dart';
import 'package:uninet/core/utils/extensions.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeIndex = ref.watch(authIndexRoute);
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  ref.read(authIndexRoute.notifier).state = 0;
                },
                child: Text(
                  'Login',
                  style: routeIndex == 0
                      ? context.style.headlineLarge
                      : context.style.headlineMedium,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ref.read(authIndexRoute.notifier).state = 1;
                },
                child: Text(
                  'Sign up',
                  style: routeIndex == 1
                      ? context.style.headlineLarge
                      : context.style.headlineMedium,
                ),
              ),
              const Spacer(),
            ],
          ),
          [
            FadeInLeft(
              child: const LoginScreen(),
            ),
            FadeInRight(
              child: const SignUpScreen(),
            ),
          ][routeIndex]
        ],
      ),
    );
  }
}
