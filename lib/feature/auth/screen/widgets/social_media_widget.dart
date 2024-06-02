import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });
  final String icon;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
