import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/router/routes_name.dart';
import '../../../core/router/routing.dart';
import '../../../core/services/remoteServices/base_model.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/validation.dart';
import '../../../core/utils/extensions.dart';
import '../provider/login_provider.dart';
import '../provider/redirect_route_provider.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/snackbar_widget.dart';

import '../../widgets/textField_widget.dart';
import 'widgets/social_media_widget.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(loginProvider, (prev, next) {
      next.when(data: (user) {
        Navigator.pop(context);
        RouteManager.goToAndRemove(RouteName.mainAppScreen);
        showSnackBarCustom(
            text: 'Logged in successfully', backgroundColor: Colors.green);
        print(user);
      }, error: (e, _) {
    Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });
    return Form(
      key: formKey,
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            hintText: '••••••••••••',
            labelText: 'Password',
            validator: (value) => value!.isValidPassword,
            isPassword: true,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
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
                if (formKey.currentState!.validate()) {
                  ref.read(loginProvider.notifier).login(
                      email: emailController.text,
                      password: passwordController.text);
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
              SocialMediaWidget(
                icon: AssetPath.appleIcon,
                color: Colors.black,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
