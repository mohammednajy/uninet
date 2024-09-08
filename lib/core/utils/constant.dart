import 'package:flutter/material.dart';

import '../router/routing.dart';

class ColorManager {
  static const Color grey = Color(0xFF778087);
  static const Color borderColor = Color(0xFFEDEDED);
  static const Color green = Color(0xFF76D676);
  static const Color blue = Color(0xFF4169E1);
  static const Color background = Color(0xFFF5F5F5);
  static const Color blueBackground = Color(0xFFDFEAF5);
}

class AssetPath {
  static const String baseIcon = 'assets/icons/';
  static const String baseImage = 'assets/images/';

// this for icons path
  static const String appleIcon = '${baseIcon}apple_icon.svg';
  static const String googleIcon = '${baseIcon}google_icon.svg';
  static const String facebookIcon = '${baseIcon}facebook_icon.svg';
  static const String visibilityOff = '${baseIcon}visibility_off.svg';
  static const String visibilityOn = '${baseIcon}visibility_on.svg';
  static const String homeIcon = '${baseIcon}home_icon.svg';
  static const String chatIcon = '${baseIcon}chat_icon.svg';
  static const String communityIcon = '${baseIcon}community_icon.svg';
  static const String searchIcon = '${baseIcon}search.svg';
  static const String notificationIcon = '${baseIcon}notification.svg';
  static const String likeIcon = '${baseIcon}like_icon.svg';
  static const String commentIcon = '${baseIcon}comment_icon.svg';
  static const String retweetIcon = '${baseIcon}retweet_icon.svg';
  static const String shareIcon = '${baseIcon}share_icon.svg';
  static const String settingsIcon = '${baseIcon}setting_icon.svg';

// this for image path
  static const String checkEmailImage = '${baseImage}check_email_image.png';
  static const String postImage = '${baseImage}postImage.png';
}

double height =
    MediaQuery.of(RouteManager.navigatorKey.currentContext!).size.height;
double width =
    MediaQuery.of(RouteManager.navigatorKey.currentContext!).size.width;

List<String> countries = [
  'Algeria',
  'Bahrain',
  'Comoros',
  'Djibouti',
  'Egypt',
  'Iraq',
  'Jordan',
  'Kuwait',
  'Lebanon',
  'Libya',
  'Mauritania',
  'Morocco',
  'Oman',
  'Palestine',
  'Qatar',
  'Saudi Arabia',
  'Somalia',
  'Sudan',
  'Syria',
  'Tunisia',
  'United Arab Emirates',
  'Yemen'
];

List<String> chasingCategoryList = [
  "Technology",
  "Fashion",
  "Travel",
  "Food",
  "Health & Fitness",
  "Entertainment",
  "Sports",
  "Art & Design",
  "Education",
  "Gaming",
  "Photography",
  "others"
];
