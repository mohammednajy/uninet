import 'package:flutter/material.dart';
import 'package:uninet/core/utils/extensions.dart';

import '../../core/router/routing.dart';


class TitleWidget extends StatelessWidget {
  const TitleWidget({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
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
            style: context.style.headlineLarge,
          )
        ],
      ),
    );
  }
}
