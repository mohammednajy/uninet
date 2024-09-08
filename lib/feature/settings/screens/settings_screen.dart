import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:uninet/feature/settings/screens/widgets/settings_widget.dart';
import '../../widgets/headline_appbar.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HeadlineAppBar(title: 'Settings'),
      body: ListView(
        children: const [
          SettingsWidget(text: 'Edit account Info.'),
          Divider(),
          SettingsWidget(text: 'Change Password'),
          Divider(),
          SettingsWidget(text: 'Terms and Conditions'),
          Divider(),
          SettingsWidget(text: 'Privacy Policy'),
          Divider(),
          SettingsWidget(text: 'Invite Friends'),
          Divider(),
          SettingsWidget(text: 'Deactivate My Account!'),
          Divider(),
          SettingsWidget(text: 'Logout'),
        ],
      ),
    );
  }
}
