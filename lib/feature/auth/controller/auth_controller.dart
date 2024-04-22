import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  int pageIndex = 0;

  clickToNavigate(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
