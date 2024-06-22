import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/auth/models/user_model.dart';
import 'package:uninet/feature/posts/model/post_model.dart';
import 'package:uninet/feature/widgets/decorated_button.dart';
import 'package:uninet/feature/widgets/post_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Feed',
          style: context.style.headlineLarge,
        ),
        actions: [
          DecoratedButton(
            path: AssetPath.notificationIcon,
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          DecoratedButton(
              path: AssetPath.searchIcon,
              onPressed: () {
                print('object');
              }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Skeletonizer(
        enabled: false,
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

List<Post> posts = [
  Post(
      userModel: UserModel(
          email: 'mohammed@gmail.com',
          userId: '111',
          name: 'ahmed mohammed',
          image: AssetPath.postImage),
      images: [AssetPath.postImage],
      description: 'Flutter post description',
      likes: 100,
      retweet: 40,
      comment: [
        Comment(
            details: 'comments',
            user: UserModel(
                email: 'mohammed@g.com',
                userId: '222',
                image: AssetPath.postImage,
                name: 'mohammed naji'))
      ]),
  Post(
      userModel: UserModel(
          email: 'mohammed@gmail.com',
          userId: '111',
          name: 'ahmed mohammed',
          image: AssetPath.postImage),
      description: 'Flutter post description',
      likes: 100,
      retweet: 40,
      comment: [
        Comment(
            details: 'comments',
            user: UserModel(
                email: 'mohammed@g.com',
                userId: '222',
                image: AssetPath.postImage,
                name: 'mohammed naji'))
      ]),
  Post(
      userModel: UserModel(
          email: 'mohammed@gmail.com',
          userId: '111',
          name: 'ahmed mohammed',
          image: AssetPath.postImage),
      images: [AssetPath.postImage],
      likes: 100,
      retweet: 40,
      comment: [
        Comment(
            details: 'comments',
            user: UserModel(
                email: 'mohammed@g.com',
                userId: '222',
                image: AssetPath.postImage,
                name: 'mohammed naji'))
      ]),
];
