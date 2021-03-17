import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

import 'children/left_child_1.dart';
import 'notifier/drawer_notifier.dart';
import 'children/right_child_1.dart';
import 'scaffolds/scaffolds_1.dart';

class ExampleOne extends StatelessWidget {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  String _title = "One";

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    print("example 1");
    //final drawerNotifier = Provider.of<DrawerNotifier>(context, listen: true);

    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: context.select((DrawerNotifier value) => value.onTapToClose),
      tapScaffoldEnabled:
          context.select((DrawerNotifier value) => value.tapScaffold),
      velocity: 20,
      swipeChild: true,
      offset: IDOffset.horizontal(
          context.select((DrawerNotifier value) => value.offset)),
      swipe: context.select((DrawerNotifier value) => value.swipe),
      colorTransitionChild:
          context.select((DrawerNotifier value) => value.colorTransition),
      colorTransitionScaffold:
          context.select((DrawerNotifier value) => value.colorTransition),
      leftAnimationType:
          context.select((DrawerNotifier value) => value.animationType),
      rightAnimationType: InnerDrawerAnimation.linear,

      leftChild: LeftChild(),

      rightChild: RightChild(innerDrawerKey: _innerDrawerKey),

      scaffold: ScaffoldDrawer(innerDrawerKey: _innerDrawerKey),

      onDragUpdate: (double value, InnerDrawerDirection direction) {
        //BAD: DO NOT DO THIS, take it as a general example.
        // We working to find a solution.
        //drawerNotifier.setSwipeOffset(value);
        context.read<DrawerNotifier>().setSwipeOffset(value);
      },
      //innerDrawerCallback: (a) => print(a),
    );
  }
}
