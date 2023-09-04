import 'package:flutter/material.dart';

import 'constant.dart';

class StyleManager {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.79,
    color: Colors.black
  );

  static const TextStyle secondaryHeadline = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 2.15,
      color: ColorManager.grey);

  static const TextStyle label = TextStyle(
    color: ColorManager.grey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelSmall = TextStyle(
    color: ColorManager.grey,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle buttonText = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallBody = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
