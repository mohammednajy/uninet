import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/feature/auth/models/user_model.dart';
import 'package:uninet/feature/widgets/post_button_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    this.image,
    this.description,
    required this.likes,
    required this.retweet,
    required this.comments,
    required this.user,
  });
  final UserModel user;
  final String? image;
  final String? description;
  final int likes;
  final int retweet;
  final int comments;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: user.image != null
                  ? Image.asset(user.image!)
                  : const Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.grey,
                    ),
            ),
            title: Text(user.name ?? ''),
            subtitle: const Text('23 min'),
            trailing: PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Edit your post'),
                ),
                const PopupMenuDivider(
                  height: 15,
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Delete your post'),
                )
              ],
            )),
        image != null
            ? Container(
                height: 190,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  image!,
                  fit: BoxFit.fill,
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        description != null ? Text(description!) : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostButton(
              title: '${likes}K',
              icon: AssetPath.likeIcon,
              onTap: () {},
              isLiked: false,
            ),
            PostButton(
              title: '$comments',
              icon: AssetPath.commentIcon,
              onTap: () {},
              isLiked: false,
            ),
            PostButton(
              title: '$retweet',
              icon: AssetPath.retweetIcon,
              onTap: () {},
              isLiked: false,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AssetPath.shareIcon),
            )
          ],
        ),
      ],
    );
  }
}
