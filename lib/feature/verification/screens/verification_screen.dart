import 'package:flutter/material.dart';

import '../../../utils/style_manager.dart';
import '../../widgets/title_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(
            title: 'Reset your Password',
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            'Please upload your documents',
            style: StyleManager.label,
          ),
        ],
      ),
    );
  }
}
