import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/widgets/decorated_button.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarWidget(
        title: "Community",
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget(
      {super.key,
      required this.title,
      this.onPressedNotification,
      this.onPressedRight,
      this.iconPath = AssetPath.searchIcon});
  final String title;
  final void Function()? onPressedNotification;
  final void Function()? onPressedRight;
  final String iconPath;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 55,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: context.style.headlineLarge,
      ),
      actions: [
        DecoratedButton(
          path: AssetPath.notificationIcon,
          onPressed: onPressedNotification,
        ),
        const SizedBox(
          width: 10,
        ),
        DecoratedButton(path: iconPath, onPressed: onPressedRight),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
