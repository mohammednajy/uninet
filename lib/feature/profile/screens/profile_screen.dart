import 'package:flutter/material.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/widgets/decorated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Messages',
          style: context.style.headlineLarge,
        ),
        actions: [
          DecoratedButton(
            path: AssetPath.notificationIcon,
            onPressed: () {
              print('object');
            },
          ),
          const SizedBox(
            width: 10,
          ),
          DecoratedButton(
              path: AssetPath.searchIcon,
              onPressed: () {
                print('object');
              }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
