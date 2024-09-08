import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/auth/provider/get_user_provider.dart';
import 'package:uninet/feature/posts/model/post_model.dart';
import 'package:uninet/feature/posts/providers/comment_provider.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';
import 'package:uninet/feature/widgets/loading_widget.dart';
import 'package:uninet/feature/widgets/snackbar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

showCommentsSheet(
  BuildContext context, {
  required Post post,
}) {
  return showModalBottomSheet(
      context: context,
      barrierColor: Colors.grey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return CommentWidget(
          post: post,
        );
      });
}

class CommentWidget extends HookConsumerWidget {
  const CommentWidget({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final userData = ref.watch(userDataProvider);
    final showComments = ref.watch(showAllComments(post.postId!));
    ref.listen(sendCommentProvider, (pref, next) {
      next.when(
        data: (data) {
          RouteManager.pop();
          print(data);
        },
        error: (error, _) {
          RouteManager.pop();
          showSnackBarCustom(
            text: error.toString(),
            backgroundColor: Colors.grey,
          );
        },
        loading: () {
          loadingWithText();
        },
      );
    });

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetTemplateWidget(
        title: 'Comments',
        widget: Column(
          children: [
            showComments.when(
              data: (data) => Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(
                      data[index].user.image!,
                    ),
                    radius: 25,
                  ),
                  title: Text(
                    data[index].user.userName ?? 'demo account',
                    style: context.style.labelSmall,
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].details),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            timeago.format(data[index].timestamp.toDate()),
                            style: context.style.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                itemCount: data.length,
              )),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator.adaptive(),
            ),
            TextField(
              autofocus: true,
              maxLines: 2,
              controller: commentController,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: 'Write your comment ...',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: ColorManager.blue,
                  ),
                  onPressed: () {
                    userData.whenData((value) async {
                      ref.read(sendCommentProvider.notifier).sendNewComment(
                            comment: Comment(
                                details: commentController.text,
                                user: value,
                                timestamp: Timestamp.now()),
                            postId: post.postId!,
                          );
                      commentController.clear();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
