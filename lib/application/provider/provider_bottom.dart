import 'package:flutter/material.dart';

class ProviderBottomNavigation extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageChange(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
