import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/utils/constant.dart';

import 'package:uninet/utils/extensions.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.hintText,
    required this.labelText,
    required this.validator,
    this.filedKey,
    this.controller,
    this.isPassword = false,
    this.readOnly,
    this.lines,
    this.onTap,
    this.suffixIcon,
    super.key,
  });
  final String labelText;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Key? filedKey;
  final TextEditingController? controller;
  final int? lines;
  final bool? readOnly;
  final void Function()? onTap;
  final Widget? suffixIcon;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: context.style.headlineMedium!.copyWith(fontSize: 14),
        ),
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly ?? false,
          minLines: widget.lines,
          maxLines: widget.lines,
          controller: widget.controller,
          key: widget.filedKey,
          obscureText: visibility,
          validator: widget.validator,
          decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon ??
                  (widget.isPassword
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          icon: SvgPicture.asset(
                            visibility
                                ? AssetPath.visibilityOff
                                : AssetPath.visibilityOn,
                          ))
                      : const SizedBox())),
        )
      ],
    );
  }
}
