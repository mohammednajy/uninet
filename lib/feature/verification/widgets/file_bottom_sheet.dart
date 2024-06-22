import 'package:flutter/material.dart';
import 'package:uninet/feature/verification/widgets/upload_file_widget.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';

showSheet(
  BuildContext context, {
  required void Function()? onTapGallery,
  required void Function()? onTapCamera,
  required String title,
}) {
  return showModalBottomSheet(
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
          title: title,
          widget: Row(
            children: [
              Expanded(
                  child: UploadFileButtonWidget(
                      onTap: onTapGallery,
                      icon: Icons.image,
                      height: 100,
                      title: 'From Gallery')),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: UploadFileButtonWidget(
                      onTap: onTapCamera,
                      icon: Icons.camera_enhance,
                      height: 100,
                      title: 'Take Picture')),
            ],
          ),
        );
      });
}
