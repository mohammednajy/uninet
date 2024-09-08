import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/router/routes_name.dart';
import '../../../core/router/routing.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../auth/models/user_model.dart';
import '../../auth/provider/logout_provider.dart';
import '../../auth/provider/redirect_route_provider.dart';
import '../../auth/repo/auth_repo.dart';
import '../providers/post_provider.dart';
import '../../posts/model/post_model.dart';
import '../../widgets/decorated_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/snackbar_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPosts = ref.watch(showAllPosts);

    ref.listen(logoutProvider, (pre, next) {
      next.when(data: (va) {
        Navigator.pop(context);
        RouteManager.goToAndRemove(RouteName.authRoute);
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });
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
            onPressed: () {
              ref.read(logoutProvider.notifier).logout();
            },
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
      body: showPosts.when(data: (data) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => PostWidget(
            post: data[index],
          ),
          itemCount: data.length,
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
          ),
        );
      }, error: (error, _) {
        return Text(error.toString());
      }, loading: () {
        return Skeletonizer(
          enabled: true,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => PostWidget(
              post: posts[0],
              // loading: true,
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
          ),
        );
      }),
    );
  }
}

List<Post> posts = [
  Post(
      timeStamp: Timestamp.now(),
      postId: '',
      userModel: UserModel(
          email: 'mohammed@gmail.com',
          userId: '111',
          name: 'ahmed mohammed',
          image:
              'https://firebasestorage.googleapis.com/v0/b/uninet-32c4a.appspot.com/o/postPhoto%2FScreenshot%202024-06-11%20at%2017.45.41.png?alt=media&token=90f6d0f2-73b4-4576-8d49-058d23cdc282'),
      images: [
        'https://firebasestorage.googleapis.com/v0/b/uninet-32c4a.appspot.com/o/postPhoto%2FScreenshot%202024-06-11%20at%2017.45.41.png?alt=media&token=90f6d0f2-73b4-4576-8d49-058d23cdc282'
      ],
      description: 'Flutter post description',
      likes: [],
      retweet: [],
      comment: [
        Comment(
            details: 'comments',
            timestamp: Timestamp.now(),
            user: UserModel(
                email: 'mohammed@g.com',
                userId: '222',
                image: AssetPath.postImage,
                name: 'mohammed naji'))
      ]),
];
