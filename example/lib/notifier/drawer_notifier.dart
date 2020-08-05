import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class DrawerNotifier extends ChangeNotifier {
  double swipeOffset = 0;
  bool onTapToClose = false;
  bool swipe = true;
  bool tapScaffold = true;
  InnerDrawerAnimation animationType = InnerDrawerAnimation.static;
  double offset = 0.4;
  Color colorTransition = Colors.black54;

  InnerDrawerDirection direction = InnerDrawerDirection.start;

  void setSwipeOffset(double value) {
    swipeOffset = value;
    notifyListeners();
  }

  void setSwipe(bool s) {
    swipe = s;
    notifyListeners();
  }

  void setTapScaffold(bool t) {
    tapScaffold = t;
    notifyListeners();
  }

  void setOnTapToClose(bool c) {
    onTapToClose = c;
    notifyListeners();
  }

  void setAnimationType(InnerDrawerAnimation t) {
    animationType = t;
    notifyListeners();
  }

  void setOffset(double o) {
    offset = o;
    notifyListeners();
  }

  void setDirection(InnerDrawerDirection d) {
    direction = d;
    notifyListeners();
  }

  void setColorTransition(Color c) {
    colorTransition = c;
    notifyListeners();
  }
}
