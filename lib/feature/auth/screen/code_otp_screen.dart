import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uninet/router/routes_name.dart';
import 'package:uninet/router/routing.dart';
import 'package:uninet/utils/constant.dart';
import 'package:uninet/utils/style_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:uninet/utils/validation.dart';
import 'package:uninet/utils/extensions.dart';

import '../../widgets/title_widget.dart';

class CodeOtpScreen extends StatefulWidget {
  const CodeOtpScreen({super.key});

  @override
  State<CodeOtpScreen> createState() => _CodeOtpScreenState();
}

class _CodeOtpScreenState extends State<CodeOtpScreen> {
  late final TextEditingController pinController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(
            title: 'Check your Email',
          ),
          SizedBox(
            height: height / 5,
          ),
          Image.asset(
            AssetPath.checkEmailImage,
            height: 87,
            width: 150,
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: formKey,
            child: Pinput(
              controller: pinController,
              cursor: const Text('_'),
              validator: (value) => value!.isValidOtp,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              autofillHints: const [AutofillHints.oneTimeCode],
              errorPinTheme: PinTheme(
                  height: 55,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red))),
              focusedPinTheme: PinTheme(
                  height: 55,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green))),
              length: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              errorTextStyle: const TextStyle(
                height: 0.5,
                color: Colors.red,
              ),
              toolbarEnabled: false,
              defaultPinTheme: PinTheme(
                height: 55,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  RouteManager.pushNamed(RouteName.newPasswordScreen);
                }
              },
              child: const Text(
                'Verify',
              )),
          const SizedBox(
            height: 17,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Did not receive the OTP? ',
                  style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  children: [
                    TextSpan(
                        text: 'Resend.',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('object');
                          })
                  ]))
        ],
      ),
    );
  }
}
