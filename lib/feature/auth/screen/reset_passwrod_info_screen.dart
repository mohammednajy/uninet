import 'package:flutter/material.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/feature/widgets/headline_appbar.dart';

class ResetPasswordInfoScreen extends StatelessWidget {
  const ResetPasswordInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeadlineAppBar(
        title: '',
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              AssetPath.checkEmailImage,
              height: 100,
              width: 150,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'We send a new email, check you email to reset your password...',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                RouteManager.goToAndRemove(RouteName.authRoute);
              },
              child: const Text('Back to Login'),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
