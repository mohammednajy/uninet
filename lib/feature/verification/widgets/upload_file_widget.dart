import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/feature/verification/controller/verification_controller.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          UploadFileButtonWidget(
            title: 'Click to upload front side',
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.grey,
                  constraints: const BoxConstraints.tightFor(height: 200),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  builder: (context) {
                    return BottomSheetTemplateWidget(
                      title: 'Upload Profile Picture',
                      widget: Row(
                        children: [
                          Expanded(
                              child: UploadFileButtonWidget(
                                  onTap: () {
                                    print('from gallery');
                                  },
                                  icon: Icons.image,
                                  height: 100,
                                  title: 'From Gallery')),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: UploadFileButtonWidget(
                                  onTap: () {
                                    print('from camera');
                                  },
                                  icon: Icons.camera_enhance,
                                  height: 100,
                                  title: 'Take Picture')),
                        ],
                      ),
                    );
                  });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          UploadFileButtonWidget(
            title: 'Click to upload front side',
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.grey,
                  constraints: const BoxConstraints.tightFor(height: 200),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  builder: (context) {
                    return BottomSheetTemplateWidget(
                      title: 'Upload Profile Picture',
                      widget: Row(
                        children: [
                          Expanded(
                              child: UploadFileButtonWidget(
                                  onTap: () {
                                    RouteManager.pop();
                                    context
                                        .read<VerificationController>()
                                        .getImage(source: ImageSource.gallery);
                                  },
                                  icon: Icons.image,
                                  height: 100,
                                  title: 'From Gallery')),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: UploadFileButtonWidget(
                                  onTap: () {
                                    RouteManager.pop();
                                    context
                                        .read<VerificationController>()
                                        .getImage(source: ImageSource.camera);
                                  },
                                  icon: Icons.camera_enhance,
                                  height: 100,
                                  title: 'Take Picture')),
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}

class UploadFileButtonWidget extends StatelessWidget {
  const UploadFileButtonWidget({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.height,
    this.color,
  });
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Selector<VerificationController, File?>(
      selector: (p0, p1) => p1.file,
      builder: (_, data, __) => InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: height ?? 150,
          child: DottedBorder(
              strokeWidth: 2,
              strokeCap: StrokeCap.square,
              color: Colors.grey.shade300,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [8, 4],
              child: Container(
                color: color,
                alignment: Alignment.center,
                child: data != null
                    ? Image.file(
                        data,
                        fit: BoxFit.fill,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon ?? Icons.upload_file,
                            color: Colors.blue,
                            size: 40,
                          ),
                          Text(
                            title,
                          )
                        ],
                      ),
              )),
        ),
      ),
    );
  }
}
