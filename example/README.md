# Example Inner Drawer

An example of how you could implement it.

## Getting Started - Inner Drawer

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'example_1.dart';
import 'example_2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inner Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
      ),
      home: MainApp(),
    );
  }
}

enum Example {
  one,
  two,
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  Example _currentExample = Example.one;

  @override
  initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
    ));

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.black45,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _switchWidget(_currentExample),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 2,
                  0.0,
                ),
                child: _item(title: "One", example: Example.one),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 1,
                  0.0,
                ),
                child: _item(title: "Two", example: Example.two),
              ),
              _toggle(),
            ],
          ),
        )
      ],
    );
  }

  Widget _switchWidget(Example example) {
    switch (example) {
      case Example.one:
        return ExampleOne();
        break;
      case Example.two:
        return ExampleTwo();
        break;
    }
  }

  Widget _item({String title, Example example}) {
    //print(((_translateButton.value-66)/60).abs());
    double val = ((_translateButton.value - 56) / 60).abs();
    return Opacity(
      opacity: val > 0 ? 1 : 0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: val,
        onPressed: () {
          setState(() => _currentExample = example);
          _animate();
        },
        tooltip: 'Apri',
        child: Text(
          title,
          style: TextStyle(
              fontSize: 11,
              color: example == Example.one
                  ? Colors.green[300]
                  : Colors.orange[300]),
        ),
      ),
    );
  }

  Widget _toggle() {
    return new Container(
      child: FloatingActionButton(
        elevation: 1.5,
        backgroundColor: Colors.white,
        onPressed: _animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: _buttonColor.value,
          progress: _animateIcon,
        ),
      ),
    );
  }

  void _animate() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }
}

```

## DEMO
![Demo 1](https://github.com/Dn-a/flutter_inner_drawer/blob/master/assets/img/example5.1.gif)
![Demo 2](https://github.com/Dn-a/flutter_inner_drawer/blob/master/assets/img/example5.3.gif)

## Other
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
