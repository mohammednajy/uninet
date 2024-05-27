import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/validation.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/auth/controller/auth_controller.dart';

import '../../widgets/textField_widget.dart';
import '../widgets/social_media_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, data, child) => Form(
        key: data.formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Please fill below information to access your account!',
              style: context.style.headlineMedium!.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: height / 8,
            ),
            TextFieldWidget(
              hintText: 'example@gmail.com',
              labelText: 'Your Email',
              validator: (value) => value!.isValidEmail,
              controller: data.emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              hintText: '••••••••••••',
              labelText: 'Password',
              validator: (value) => value!.isValidPassword,
              isPassword: true,
              controller: data.passwordController,
            ),
            TextButton(
                onPressed: () {
                  RouteManager.pushNamed(RouteName.resetPasswordRoute);
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerRight,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                )),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (data.formKey.currentState!.validate()) {
                    await data.login();
                  }
                },
                child: const Text(
                  'Login',
                )),
            SizedBox(
              height: height / 8,
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
                  onTap: () {},
                ),
                const SizedBox(
                  width: 15,
                ),
                SocialMediaWidget(
                  icon: AssetPath.facebookIcon,
                  color: Colors.blue,
                  onTap: () {},
                ),
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
