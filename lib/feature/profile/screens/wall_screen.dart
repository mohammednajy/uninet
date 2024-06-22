import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/feature/widgets/post_widget.dart';

import '../../home/screens/home_screen.dart';

class WallScreen extends HookConsumerWidget {
  const WallScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: FadeInLeft(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => PostWidget(
            likes: posts[index].likes,
            retweet: posts[index].retweet,
            comments: posts[index].comment.length,
            user: posts[index].userModel,
            description: posts[index].description,
            image: posts[index].images?.first,
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
