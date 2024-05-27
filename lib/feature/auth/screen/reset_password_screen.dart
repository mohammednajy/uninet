import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/core/utils/validation.dart';
import 'package:uninet/feature/auth/controller/auth_controller.dart';
import 'package:uninet/feature/auth/screen/new_password_screen.dart';

import '../../widgets/textField_widget.dart';
import '../../widgets/headline_appbar.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  GlobalKey<FormFieldState> filedKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeadlineAppBar(
        title: 'Reset Your Password',
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Please enter your registered email to reset your password!',
            style: context.style.headlineMedium!.copyWith(fontSize: 14),
          ),
          SizedBox(
            height: height / 5,
          ),
          TextFieldWidget(
            filedKey: filedKey,
            hintText: 'example@gmail.com',
            labelText: 'Your Email',
            validator: (value) => value!.isValidEmail,
            controller: emailController,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                if (filedKey.currentState!.validate()) {
                  context
                      .read<AuthController>()
                      .sendRestPasswordEmail(email: emailController.text);
                }
              },
              child: const Text(
                'Reset Password',
              )),
          SizedBox(
            height: height / 4,
          ),
          Text(
            'Remember your Password?',
            style: context.style.headlineMedium!.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              RouteManager.pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5F5F5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: ColorManager.blue,
                    ))),
            child: const Text(
              'Back to Login',
              style: TextStyle(color: ColorManager.blue),
            ),
          )
        ],
      ),
    );
  }
}
