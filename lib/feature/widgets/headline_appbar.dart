import 'package:flutter/material.dart';
import '../../core/router/routing.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/extensions.dart';

class HeadlineAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeadlineAppBar(
      {super.key, this.leading = true, required this.title, this.trailing});
  final String title;
  final bool leading;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: ColorManager.background,
      elevation: 0,
      actions: trailing != null
          ? [
              trailing!,
              const SizedBox(
                width: 20,
              ),
            ]
          : [],
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
