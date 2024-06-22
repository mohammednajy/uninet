import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/core/utils/validation.dart';
import 'package:uninet/feature/auth/provider/singup_provider.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';
import 'package:uninet/feature/widgets/loading_widget.dart';

import '../../../core/utils/constant.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/textField_widget.dart';
import 'widgets/social_media_widget.dart';
import 'package:uninet/core/utils/extensions.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final checkboxValue = ref.watch(checkboxValueProvider);
    ref.listen(singUpProvider, (prev, next) {
      next.when(data: (user) {
        Navigator.pop(context);
        showSnackBarCustom(
            text: 'Registered successfully', backgroundColor: Colors.green);
        ref.read(authIndexRoute.notifier).state = 0;
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString() ?? '');
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            hintText: '••••••••••••',
            labelText: 'Password',
            controller: passwordController,
            validator: (value) => value!.isValidPassword,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            hintText: '••••••••••••',
            labelText: 'Confirm your Password',
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else if (value != passwordController.text) {
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
              value: checkboxValue,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {
                ref.read(checkboxValueProvider.notifier).state = value ?? false;
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
                if (checkboxValue) {
                  ref.read(singUpProvider.notifier).singUp(
                      email: emailController.text,
                      password: passwordController.text);
                } else {
                  showSnackBarCustom(
                      text: 'Please, Confirm you are above 18 years old',
                      backgroundColor: Colors.grey);
                }
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
                  ref.read(singUpProvider.notifier).singUpWithGoogle();
                },
              ),
              const SizedBox(
                width: 15,
              ),
              SocialMediaWidget(
                  icon: AssetPath.facebookIcon,
                  color: Colors.blue,
                  onTap: () async {
                    ref.read(singUpProvider.notifier).singUpWithFacebook();
                  }),
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
