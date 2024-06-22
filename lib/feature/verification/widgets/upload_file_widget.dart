import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({
    super.key,
    this.backSideImage,
    this.frontSideImage,
    required this.onTapBack,
    required this.onTapFront,
  });
  final File? frontSideImage;
  final File? backSideImage;
  final void Function()? onTapFront;
  final void Function()? onTapBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          UploadFileButtonWidget(
            title: 'Click to upload front side',
            image: frontSideImage,
            onTap: onTapFront,
          ),
          const SizedBox(
            height: 10,
          ),
          UploadFileButtonWidget(
            title: 'Click to upload back side',
            image: backSideImage,
            onTap: onTapBack,
          )
        ],
      ),
    );
  }
}

class UploadFileButtonWidget extends StatelessWidget {
  const UploadFileButtonWidget(
      {super.key,
      required this.title,
      this.icon,
      this.onTap,
      this.height,
      this.color,
      this.image});
  final String title;
  final IconData? icon;
  final void Function()? onTap;
  final double? height;
  final Color? color;
  final File? image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Container(
                    color: color,
                    alignment: Alignment.center,
                    child: Column(
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
    );
  }
}
