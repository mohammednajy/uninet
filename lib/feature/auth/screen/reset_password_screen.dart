import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/router/routes_name.dart';
import '../../../core/router/routing.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validation.dart';
import '../provider/reset_password_provider.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/snackbar_widget.dart';

import '../../widgets/textField_widget.dart';
import '../../widgets/headline_appbar.dart';

class RestPasswordScreen extends HookConsumerWidget {
  const RestPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filedKey = useMemoized(GlobalKey<FormFieldState>.new);
    final emailController = useTextEditingController();
    ref.listen(resetPasswordProvider, (prev, next) {
      next.when(data: (value) {
        RouteManager.pop();
        showSnackBarCustom(
            text: 'Email send successfully, check you email',
            backgroundColor: Colors.green);
        RouteManager.pushNamed(RouteName.resetPasswordInfoScreen);
        print(value);
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });
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
                  ref
                      .read(resetPasswordProvider.notifier)
                      .sendResetPassword(email: emailController.text);
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
