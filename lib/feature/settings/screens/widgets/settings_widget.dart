import 'package:flutter/material.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
        radius: 204,
        backgroundColor: ColorManager.blueBackground,
        child: Icon(Icons.settings),
      ),
      title: Text(
        text,
        style: context.style.labelSmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
