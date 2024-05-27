import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uninet/feature/auth/controller/auth_controller.dart';
import 'package:uninet/core/utils/validation.dart';

import '../../../core/utils/constant.dart';
import '../../widgets/textField_widget.dart';
import '../widgets/social_media_widget.dart';
import 'package:uninet/core/utils/extensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkListValue = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Consumer<AuthController>(
        builder: (context, data, child) => ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Please fill the following information to create new account',
              style: context.style.headlineMedium!.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: height / 40,
            ),
            TextFieldWidget(
              hintText: 'example@gmail.com',
              labelText: 'Your Email',
              validator: (value) => value!.isValidEmail,
              controller: data.emailControllerSingUp,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              hintText: '••••••••••••',
              labelText: 'Password',
              controller: data.passwordControllerSingUp,
              validator: (value) => value!.isValidPassword,
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              hintText: '••••••••••••',
              labelText: 'Confirm your Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (value != data.passwordControllerSingUp.text) {
                  return 'not match';
                }
                return null;
              },
              isPassword: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Must be at least 8 characters with one number and one special character',
              style: context.style.headlineMedium!.copyWith(fontSize: 12),
            ),
            CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                value: checkListValue,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  setState(() {
                    checkListValue = value ?? false;
                  });
                },
                title: Text(
                  'Confirm you are above 18 years old',
                  style: context.style.labelSmall!.copyWith(
                    fontSize: 12,
                  ),
                )),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  data.singUp();
                }
              },
              child: const Text(
                'Sign Up',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'by clicking sign up you agree to the terms and conditions and our privacy policy',
              textAlign: TextAlign.center,
              style: context.style.headlineMedium!.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: height / 40,
            ),
            Text(
              'Or continue with',
              style: context.style.headlineMedium!.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SocialMediaWidget(
                  icon: AssetPath.googleIcon,
                  color: Colors.red,
                  onTap: () async {
                    data.signInWithGoogle();
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                SocialMediaWidget(
                    icon: AssetPath.facebookIcon,
                    color: Colors.blue,
                    onTap: () async {
                      data.singInWithFacebook();
                    }),
                const SizedBox(
                  width: 15,
                ),
                // SocialMediaWidget(
                //   icon: AssetPath.appleIcon,
                //   color: Colors.black,
                //   onTap: () {},
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
