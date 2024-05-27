import 'package:flutter/material.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';

class HeadlineAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeadlineAppBar({
    super.key,
    this.leading = true,
    required this.title,
  });
  final String title;
  final bool leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: ColorManager.background,
      elevation: 0,
      leading: leading
          ? IconButton(
              onPressed: () {
                RouteManager.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              ))
          : null,
      title: Text(
        title,
        style: context.style.headlineLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
