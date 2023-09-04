import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:uninet/feature/auth/screen/login_screen.dart';
import 'package:uninet/feature/auth/screen/signup_screen.dart';
import 'package:uninet/utils/style_manager.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Text(
                  'Login',
                  style: index == 0
                      ? StyleManager.headline
                      : StyleManager.secondaryHeadline,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Text(
                  'Sign up',
                  style: index == 1
                      ? StyleManager.headline
                      : StyleManager.secondaryHeadline,
                ),
              ),
              const Spacer(),
            ],
          ),
          [
            FadeInLeft(child: LoginScreen()),
            FadeInRight(child: SignUpScreen()),
          ][index]
        ],
      ),
    );
  }
}
