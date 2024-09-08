import 'package:flutter/material.dart';
import '../../../core/router/routing.dart';
import '../../../core/utils/validation.dart';
import '../../../core/utils/extensions.dart';

import '../../../core/utils/constant.dart';
import '../../widgets/textField_widget.dart';
import '../../widgets/headline_appbar.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeadlineAppBar(
          title: 'New Password',
        ),
        body: Form(
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            children: [
              Text(
                'Please enter the new password with confirmation and don’t share it with others!',
                style: context.style.headlineMedium!.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: height / 7,
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('succffully');
                    }
                  },
                  child: const Text(
                    'Update',
                  )),
            ],
          ),
        ));
  }
}

