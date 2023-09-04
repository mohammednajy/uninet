import 'package:flutter/material.dart';

import '../../router/routing.dart';
import '../../utils/style_manager.dart';


class TitleWidget extends StatelessWidget {
  const TitleWidget({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              RouteManager.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            )),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: StyleManager.headline,
        )
      ],
    );
  }
}
