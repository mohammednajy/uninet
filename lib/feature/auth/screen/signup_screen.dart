import 'package:flutter/material.dart';
import 'package:uninet/utils/validation.dart';

import '../../../utils/constant.dart';
import '../../../utils/style_manager.dart';
import '../../widgets/textField_widget.dart';
import '../widgets/social_media_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkListValue = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            'Please fill the following information to create new account',
            style: StyleManager.label,
          ),
          SizedBox(
            height: height / 40,
          ),
          TextFieldWidget(
            hintText: 'example@gmail.com',
            labelText: 'Your Email',
            validator: (value) => value!.isValidEmail,
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
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            hintText: '••••••••••••',
            labelText: 'Confirm your Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this field is required';
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
          const Text(
            'Must be at least 8 characters with one number and one special character',
            style: StyleManager.labelSmall,
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
              title: const Text(
                'Confirm you are above 18 years old',
                style: StyleManager.smallBody,
              )),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('succffully');
                }
              },
              child: const Text(
                'Sign Up',
              )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'by clicking sign up you agree to the terms and conditions and our privacy policy',
            textAlign: TextAlign.center,
            style: StyleManager.labelSmall,
          ),
          SizedBox(
            height: height / 40,
          ),
          const Text(
            'Or continue with',
            style: StyleManager.label,
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
