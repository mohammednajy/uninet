import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class DecoratedButton extends StatelessWidget {
  const DecoratedButton(
      {super.key, required this.path, required this.onPressed});
  final void Function()? onPressed;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(path),
      ),
    );
  }
}
