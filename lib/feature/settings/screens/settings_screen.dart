import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/feature/widgets/headline_appbar.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HeadlineAppBar(title: 'Settings'),
    );
  }
}
