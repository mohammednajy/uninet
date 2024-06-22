import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/services/remoteServices/firebase_init.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/auth/models/user_model.dart';
import 'package:uninet/feature/posts/model/post_model.dart';
import 'package:uninet/feature/posts/providers/create_post_provider.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';
import 'package:uninet/feature/widgets/headline_appbar.dart';
import 'package:uninet/feature/widgets/loading_widget.dart';
import 'package:uninet/feature/widgets/snackbar_widget.dart';

class CreateNewPostScreen extends HookConsumerWidget {
  const CreateNewPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chasingCategory = useState<String?>(null);
    final postController = useTextEditingController();
    final currentText = useState('');

    final suggestionImagesPost = ref.watch(suggestionImagesPostProvider);

    final pickImages = ref.watch(pickImagesProvider);

    useEffect(() {
      void listener() {
        currentText.value = postController.text;
      }

      postController.addListener(listener);
      return () => postController.removeListener(listener);
    }, [postController]);

    ref.listen(suggestionImagesPostProvider, (prev, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          showSnackBarCustom(text: error.toString());
        },
      );
    });

    ref.listen(createNewPostProvider, (per, nex) {
      nex.when(data: (d) {
        Navigator.pop(context);
        Navigator.pop(context);
      }, error: (error, _) {
        Navigator.pop(context);

        showSnackBarCustom(text: error.toString(), backgroundColor: Colors.red);
      }, loading: () {
        loadingWithText();
      });
    });
    return Scaffold(
      appBar: HeadlineAppBar(
        title: 'New Post',
        trailing: ElevatedButton(
          onPressed: currentText.value.isEmpty
              ? null
              : () async {
                  final user = ref.read(firebaseAuthProvider).currentUser;
                  final post = Post(
                      description: postController.text,
                      chasingCategory: chasingCategory.value,
                      userModel: UserModel(
                        email: user?.email ?? '',
                        userId: user?.uid ?? '',
                        image: user?.photoURL,
                        userName: user?.displayName,
                      ),
                      likes: 0,
                      retweet: 0,
                      comment: []);

                  await ref
                      .read(createNewPostProvider.notifier)
                      .createNewPost(post);
                },
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
          child: const Text('Post'),
        ),
      ),
      body: ListView(
        children: [
          const Divider(
            thickness: 1,
          ),
          TextField(
            maxLines: 6,
            minLines: 6,
            controller: postController,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: 'Tell your audience more..',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              chasingCategory.value == null ? '' : '#${chasingCategory.value}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.blue,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: pickImages.value!.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  pickImages.value![index],
                  IconButton(
                      onPressed: () {
                        ref
                            .read(pickImagesProvider.notifier)
                            .removeImage(index);
                      },
                      icon: const Icon(
                        Icons.cancel,
                      ))
                ],
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  builder: (context) {
                    return BottomSheetTemplateWidget(
                        title: 'Select Chasing Category',
                        widget: ListView.builder(
                            itemCount: chasingCategoryList.length,
                            itemBuilder: (context, index) => TextButton(
                                onPressed: () {
                                  chasingCategory.value =
                                      chasingCategoryList[index];

                                  RouteManager.pop();
                                },
                                child: Text(
                                  chasingCategoryList[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ))));
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chasing',
                    style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  ),
                  const Icon(
                    Icons.arrow_right,
                    size: 35,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return suggestionImagesPost.when(
                    data: (data) => InkWell(
                      onTap: suggestionImagesPost.hasError
                          ? null
                          : () {
                              index == 0
                                  ? ref
                                      .read(pickImagesProvider.notifier)
                                      .pickImages()
                                  : ref
                                      .read(pickImagesProvider.notifier)
                                      .addImage(Image.network(
                                          suggestionImagesPost.value![index]));
                            },
                      child: Container(
                        height: 70,
                        width: 80,
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.blue.shade100 : null,
                        ),
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        child: index != 0
                            ? Image.network(
                                data[index],
                                fit: BoxFit.fitHeight,
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
                              )
                            : const Icon(
                                Icons.image,
                                size: 30,
                                color: ColorManager.blue,
                              ),
                      ),
                    ),
                    error: (error, stackTrace) => const Icon(
                      Icons.error_outline,
                      size: 30,
                    ),
                    loading: () => Skeletonizer(
                        enabled: true,
                        containersColor: Colors.grey.shade200,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 70,
                          width: 80,
                          color: Colors.grey,
                        )),
                  );
                }),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
