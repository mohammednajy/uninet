import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/core/utils/constant.dart';


class PostButton extends StatelessWidget {
  const PostButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.isLiked});
  final String icon;
  final String title;
  final void Function()? onTap;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: isLiked
                  ? const ColorFilter.mode(
                      ColorManager.blue,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: isLiked ? ColorManager.blue : null),
            )
          ],
        ));
  }
}
