import 'package:flutter/material.dart';

/// Holds bottom navigation state for app shell related flows.
class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
