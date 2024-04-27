import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uninet/feature/auth/controller/auth_controller.dart';
import 'package:uninet/feature/auth/screen/login_screen.dart';
import 'package:uninet/feature/auth/screen/signup_screen.dart';
import 'package:uninet/core/utils/extensions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<AuthController,int>(
        selector: (_, p1) => p1.pageIndex,
        builder: (_,data,__) {
          return ListView(
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
                     context.read<AuthController>().clickToNavigate(0);
                    },
                    child: Text(
                      'Login',
                      style: data == 0
                          ? context.style.headlineLarge
                          : context.style.headlineMedium,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                        context.read<AuthController>().clickToNavigate(1);
                    },
                    child: Text(
                      'Sign up',
                      style: data == 1
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
              ][data]
            ],
          );
        }
      ),
    );
  }
}
