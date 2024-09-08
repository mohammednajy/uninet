import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/feature/auth/repo/auth_repo.dart';
import 'package:uninet/feature/home/providers/post_provider.dart';
import 'package:uninet/feature/posts/model/post_model.dart';
import 'package:uninet/feature/widgets/comment_widget.dart';
import '../../core/utils/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'post_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

// class PostWidget extends
class PostWidget extends StatefulHookConsumerWidget {
  final Post post;

  final bool loading;
  const PostWidget({
    super.key,
    this.loading = false,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    final isLiked = useState(false);
    final isRetweet = useState(false);
    final isComment = useState(false);

    final effectValue = useEffect(() {
      isLiked.value = widget.post.likes
          .contains(ref.read(authRepoProvider).getUser()!.userId);
      isRetweet.value = widget.post.retweet
          .contains(ref.read(authRepoProvider).getUser()!.userId);
      isComment.value = widget.post.comment
          .where((value) =>
              value.user.userId == ref.read(authRepoProvider).getUser()!.userId)
          .toList()
          .isNotEmpty;

      return () {
        print('Widget disposed');
      };
    }, []);

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
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: widget.post.userModel.image != null
                  ? Image.network(
                      widget.post.userModel.image!,
                      fit: BoxFit.fill,
                    )
                  : const Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.grey,
                    ),
            ),
            title: Text(widget.post.userModel.userName ?? ''),
            subtitle: Text(timeago.format(widget.post.timeStamp.toDate())),
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
        (widget.post.images!.isNotEmpty)
            ? Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 190.0,
                      autoPlay: true,
                      enableInfiniteScroll: widget.post.images!.length != 1,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction:
                          1.0, // Ensure images fill the entire width
                      onPageChanged: (index, reason) {
                        activeIndex.value = index;
                      },
                    ),
                    items: widget.post.images!.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.shade400),
                            clipBehavior: Clip.antiAlias,
                            child: widget.loading
                                ? Image.asset(
                                    image,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.error,
                                        size: 30,
                                      );
                                    },
                                  ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  if (widget.post.images!.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SmoothPageIndicator(
                        controller: PageController(
                            initialPage: activeIndex
                                .value), // Carousel controller for smooth page indicator
                        count: widget.post.images!.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.blue,
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          expansionFactor: 2.5,
                          dotColor: Colors.grey,
                        ),
                      ),
                    ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        widget.post.description != null
            ? Text(widget.post.description!)
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostButton(
              title: '${widget.post.likes.length}',
              icon: AssetPath.likeIcon,
              onTap: () {
                isLiked.value = !isLiked.value;
                if (isLiked.value) {
                  ref.read(addLikeProvider(widget.post.postId!));
                  effectValue;
                } else {
                  ref.read(removeLikeProvider(widget.post.postId!));
                  effectValue;
                }
              },
              isLiked: isLiked.value,
            ),
            PostButton(
              title: '${widget.post.comment.length}',
              icon: AssetPath.commentIcon,
              onTap: () async {
                await showCommentsSheet(context, post: widget.post);
                effectValue;
              },
              isLiked: isComment.value,
            ),
            PostButton(
              title: '${widget.post.retweet.length}',
              icon: AssetPath.retweetIcon,
              onTap: () {},
              isLiked: isRetweet.value,
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
