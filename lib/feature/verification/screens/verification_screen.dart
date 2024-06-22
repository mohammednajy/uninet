import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uninet/feature/verification/providers/verification_provider.dart';
import 'package:uninet/feature/verification/widgets/file_bottom_sheet.dart';
import 'package:uninet/feature/verification/widgets/upload_file_widget.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/widgets/snackbar_widget.dart';

import '../../widgets/headline_appbar.dart';
import '../../widgets/loading_widget.dart';

class VerificationScreen extends HookConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupValue = useState(0);
    // final imageFront = ref.watch(pickImageFrontProvider);
    // final imageBack = ref.watch(pickImageBackProvider);
    final pickImage = ref.watch(pickImageProvider);

    ref.listen(uploadImageProvider, (prev, next) {
      next.when(data: (url) {
        Navigator.pop(context);
        RouteManager.goToAndRemove(RouteName.completeProfileScreen);
        showSnackBarCustom(
            text: 'uploaded successfully', backgroundColor: Colors.green);
        print(url);
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });
    return Scaffold(
      appBar: const HeadlineAppBar(
        title: 'Verification',
        leading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please upload your documents',
                    style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<int>(
                          title: const Text('Identification Card'),
                          value: 0,
                          groupValue: groupValue.value,
                          onChanged: (value) {
                            groupValue.value = value ?? 0;
                          },
                        ),
                        Visibility(
                            visible: groupValue.value == 0,
                            child: UploadFileWidget(
                              frontSideImage: pickImage.asData?.value["front"],
                              backSideImage: pickImage.asData?.value["back"],
                              onTapFront: () {
                                showSheet(context, onTapGallery: () {
                                  Navigator.pop(context);
                                  // ref
                                  //     .read(pickImageFrontProvider.notifier)
                                  //     .pickImageFromFront(
                                  //         source: ImageSource.gallery);

                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.gallery,
                                          pickedSide: "front");
                                }, onTapCamera: () {
                                  Navigator.pop(context);
                                  // ref
                                  //     .read(pickImageFrontProvider.notifier)
                                  //     .pickImageFromFront(
                                  //         source: ImageSource.camera);
                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.camera,
                                          pickedSide: "front");
                                }, title: 'Upload Profile Picture');
                              },
                              onTapBack: () {
                                showSheet(context, onTapGallery: () {
                                  Navigator.pop(context);
                                  // ref
                                  //     .read(pickImageBackProvider.notifier)
                                  //     .pickImageFromBack(
                                  //         source: ImageSource.gallery);
                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.gallery,
                                          pickedSide: "back");
                                }, onTapCamera: () {
                                  Navigator.pop(context);
                                  // ref
                                  //     .read(pickImageBackProvider.notifier)
                                  //     .pickImageFromBack(
                                  //         source: ImageSource.camera);
                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.camera,
                                          pickedSide: "back");
                                }, title: 'Upload Profile Picture');
                              },
                            )),
                        RadioListTile<int>(
                          title: const Text('Drivers License'),
                          value: 1,
                          groupValue: groupValue.value,
                          onChanged: (value) {
                            groupValue.value = value ?? 0;
                          },
                        ),
                        Visibility(
                            visible: groupValue.value == 1,
                            child: UploadFileWidget(
                              frontSideImage: pickImage.asData?.value["front"],
                              backSideImage: pickImage.asData?.value["back"],
                              onTapFront: () {
                                showSheet(context, onTapGallery: () {
                                  Navigator.pop(context);

                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.gallery,
                                          pickedSide: "front");
                                }, onTapCamera: () {
                                  Navigator.pop(context);

                                  ref
                                      .read(pickImageProvider.notifier)
                                      .pickImageFromBack(
                                          source: ImageSource.camera,
                                          pickedSide: "front");
                                }, title: 'Upload Profile Picture');
                              },
                              onTapBack: () {
                                showSheet(
                                  context,
                                  onTapGallery: () {
                                    Navigator.pop(context);

                                    ref
                                        .read(pickImageProvider.notifier)
                                        .pickImageFromBack(
                                            source: ImageSource.gallery,
                                            pickedSide: "back");
                                  },
                                  onTapCamera: () {
                                    Navigator.pop(context);

                                    ref
                                        .read(pickImageProvider.notifier)
                                        .pickImageFromBack(
                                            source: ImageSource.camera,
                                            pickedSide: "back");
                                  },
                                  title: 'Upload Profile Picture',
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (pickImage.value?['front'] == null ||
                    pickImage.value?['back'] == null) {
                  showSnackBarCustom(
                      text: 'please, pick the document from the two sides');
                } else {
                  ref.read(uploadImageProvider.notifier).uploadImage(
                      image: pickImage.value!['front']!, imageSide: 'front');
                  ref.read(uploadImageProvider.notifier).uploadImage(
                      image: pickImage.value!['back']!, imageSide: 'back');
                }
              },
              child: const Text('Next'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    RouteManager.goToAndRemove(RouteName.completeProfileScreen);
                  },
                  child: Text(
                    'Skip for now',
                    style: context.style.bodyMedium,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
