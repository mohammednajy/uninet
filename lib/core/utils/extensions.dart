import 'package:flutter/material.dart';

extension ThemeStyleManager on BuildContext {
  TextTheme get style => Theme.of(this).textTheme;
}

extension UIThemeExtension on BuildContext {
  TextStyle get h1 => Theme.of(this).textTheme.bodyMedium!;
}

enum PrefKeys {
  user,
  isVerificationAppear,
  isVerificationDone,
  isCompleteProfileDone,
}
