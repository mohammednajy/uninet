import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/utils/constant.dart';

import '../../utils/style_manager.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    required this.hintText,
    required this.labelText,
    required this.validator,
    this.filedKey,
    this.controller,
    this.isPassword = false,
    super.key,
  });
  final String labelText;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Key? filedKey;
  final TextEditingController? controller;
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
          style: StyleManager.label,
        ),
        TextFormField(
          controller: widget.controller,
          key: widget.filedKey,
          obscureText: visibility,
          validator: widget.validator,
          decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: widget.isPassword
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
                  : const SizedBox()),
        )
      ],
    );
  }
}
