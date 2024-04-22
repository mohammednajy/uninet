// import 'package:flutter/material.dart';

// import 'constant.dart';
import 'package:flutter/material.dart';

class StyleManager {
  // //this is headlineLarge
  // static const TextStyle headline = TextStyle(
  //   fontSize: 24,
  //   fontWeight: FontWeight.w600,
  //   height: 1.79,
  //   color: Colors.black
  // );
  // // this is headlineMedium
  // static const TextStyle secondaryHeadline = TextStyle(
  //     fontSize: 20,
  //     fontWeight: FontWeight.w400,
  //     height: 2.15,
  //     color: ColorManager.grey);

// // headlineMedium
//   static const TextStyle label = TextStyle(
//     color: ColorManager.grey,
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//   );
//headlineMedium
  // static const TextStyle labelSmall = TextStyle(
  //   color: ColorManager.grey,
  //   fontSize: 12,
  //   fontWeight: FontWeight.w400,
  // );

  //labelSmall
  // static const TextStyle buttonText = TextStyle(
  //   color: Colors.black,
  //   fontSize: 16,
  //   fontWeight: FontWeight.w500,
  // );
  // labelSmall
  // static const TextStyle smallBody = TextStyle(
  //   color: Colors.black,
  //   fontSize: 12,
  //   fontWeight: FontWeight.w500,
  // );
}




extension UIThemeExtension on BuildContext {

  // * (default) TextTheme
  TextStyle get h1 => Theme.of(this).textTheme.bodyMedium!;

  
  }