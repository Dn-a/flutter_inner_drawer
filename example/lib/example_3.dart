import 'dart:math';

import 'package:example/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ExampleThree extends StatefulWidget {
  ExampleThree({Key key}) : super(key: key);

  @override
  _ExampleThreeState createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;

  double _borderRadius = 50;

  AnimationController _animationController;
  Animation<Color> _bkgColor;

  String _title = "Three";

  @override
  void initState() {
    _getwidthContainer();
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  Color currentColor = Colors.black54;

  void _getwidthContainer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  FocusNode myFocusNode;
  FocusNode myFocusNode2;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      //tapScaffoldEnabled: true,
      borderRadius: _borderRadius,
      swipeChild: true,
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: Material(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Left Child",
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  focusNode: myFocusNode2,
                ),
                /*ListView.builder(
                  itemCount: 5,
                  itemBuilder:(BuildContext context, int index){
                    return ListTile(title: Text('test $index'),);
                  },
                )*/
              ],
            )),
          )),
      scaffold: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            //stops: [0.1, 0.5,0.5, 0.7, 0.9],
            colors: [
              Colors.green[200],
              Colors.green[500],
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
                height: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    TextField(
                      focusNode: myFocusNode,
                    ),
                    TextField(
                        //  focusNode: myFocusNode,
                        ),
                  ],
                )),
          ),
        ),
      ),
      innerDrawerCallback: (a) {
        print(a);
        if (a) {
          myFocusNode2.requestFocus();
        } else {
          myFocusNode.requestFocus();
        }
      },
    );
  }
}
