import 'package:flutter/material.dart';
import 'package:uninet/router/routes_name.dart';
import 'package:uninet/router/routing.dart';
import 'package:uninet/utils/constant.dart';
import 'package:uninet/utils/extensions.dart';
import 'package:uninet/utils/validation.dart';

import '../../widgets/textField_widget.dart';
import '../../widgets/title_widget.dart';

class RestPasswordScreen extends StatefulWidget {
  const RestPasswordScreen({super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  GlobalKey<FormFieldState> filedKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          TitleWidget(
            title: 'Reset your Password',
          ),
          const SizedBox(
            height: 14,
          ),
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
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                if (filedKey.currentState!.validate()) {
                  RouteManager.pushNamed(RouteName.codeOtpScreen);
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
