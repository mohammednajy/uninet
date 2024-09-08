import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/post_widget.dart';

import '../../home/screens/home_screen.dart';

class LikesScreen extends HookConsumerWidget {
  const LikesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: FadeInRight(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => PostWidget(
           post: posts[index],
          ),
          itemCount: posts.length,
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
          ),
        ),
      ),
    );
  }
}
