import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'example_1.dart';
import 'example_2.dart';
import 'example_3.dart';
import 'notifier/drawer_notifier.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => DrawerNotifier(),
      child: MyApp(),
    ));

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

enum Example { one, two, three }

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
                  _translateButton.value * 3,
                  0.0,
                ),
                child: _item(title: "One", example: Example.one),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 2,
                  0.0,
                ),
                child: _item(title: "Two", example: Example.two),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 1,
                  0.0,
                ),
                child: _item(title: "Three", example: Example.three),
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
      case Example.three:
        return ExampleThree();
        break;
    }
  }

  Widget _item({String title, Example example}) {
    //print(((_translateButton.value-66)/60).abs());
    double val = ((_translateButton.value - 56) / 60).abs();
    Color color;
    switch (example) {
      case Example.one:
        color = Colors.green[300];
        break;
      case Example.two:
        color = Colors.orange[300];
        break;
      default:
        color = Colors.blue[300];
    }

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
        child: Text(title,
            style: TextStyle(
              fontSize: 11,
              color: color,
            )),
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
