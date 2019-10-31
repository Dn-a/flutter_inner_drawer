import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

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

  bool _onTapToClose = false;
  bool _swipe = true;
  bool _tapScaffold = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;
  double _scale = 1;
  double _borderRadius = 20;
  double _verticalOffset = 0.05;

  AnimationController _animationController;
  Animation<Color> _bkgColor;

  String _title = "Two";

  @override
  void initState() {
    _getwidthContainer();
    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      leftOffset: _offset,
      rightOffset: _offset,
      overlay: true,
      leftScale: _scale,
      rightScale: _scale,
      verticalOffset: _verticalOffset,
      borderRadius: _borderRadius,
      swipe: _swipe,
      colorTransition: currentColor,
      leftAnimationType: _animationType,
      rightAnimationType: _animationType,
      leftChild: Material(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[300],
                gradient: new RadialGradient(
                    colors: [Colors.red, Colors.cyan, Colors.purple, Colors.lightGreenAccent],
                    center: Alignment(0, 0),
                    radius: 2,
                    tileMode: TileMode.clamp,
                    stops: [0.3, 0.5, 0.6, 0.7]
                )
            ),
            child: Center(
              child: Container(
                child: Text(
                  "Left Child",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )),
      ),
      rightChild: Material(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Container(
              child: Text(
                "Right Child",
                style: TextStyle(fontSize: 18),
              ),
            ),
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
              Colors.blue,
              Colors.indigo,
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text('Static'),
                          Checkbox(
                              activeColor: Colors.black,
                              value:
                                  _animationType == InnerDrawerAnimation.static,
                              onChanged: (a) {
                                setState(() {
                                  _animationType = InnerDrawerAnimation.static;
                                });
                              }),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.static;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.black,
                              value:
                                  _animationType == InnerDrawerAnimation.linear,
                              onChanged: (a) {
                                setState(() {
                                  _animationType = InnerDrawerAnimation.linear;
                                });
                              }),
                          Text('Linear'),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.linear;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.black,
                              value: _animationType ==
                                  InnerDrawerAnimation.quadratic,
                              onChanged: (a) {
                                setState(() {
                                  _animationType =
                                      InnerDrawerAnimation.quadratic;
                                });
                              }),
                          Text('Quadratic'),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.quadratic;
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    Text('Offset'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                                valueIndicatorTextStyle: Theme.of(context)
                                    .accentTextTheme
                                    .body2
                                    .copyWith(color: Colors.white),
                              ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _offset,
                            min: 0.0,
                            max: 1,
                            divisions: 5,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_offset',
                            onChanged: (a) {
                              setState(() {
                                _offset = a;
                              });
                            },
                            onChangeEnd: (a) {
                              //_getwidthContainer();
                            },
                          ),
                        ),
                        Text(_offset.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    Text('Scale'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                                valueIndicatorTextStyle: Theme.of(context)
                                    .accentTextTheme
                                    .body2
                                    .copyWith(color: Colors.white),
                              ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _scale,
                            min: 0.0,
                            max: 1,
                            divisions: 10,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_scale',
                            onChanged: (a) {
                              setState(() {
                                _scale = a;
                              });
                            },
                          ),
                        ),
                        Text(_scale.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    Text('Border Radius'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                                valueIndicatorTextStyle: Theme.of(context)
                                    .accentTextTheme
                                    .body2
                                    .copyWith(color: Colors.white),
                              ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _borderRadius,
                            min: 0,
                            max: 100,
                            divisions: 4,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_borderRadius',
                            onChanged: (a) {
                              setState(() {
                                _borderRadius = a;
                              });
                            },
                          ),
                        ),
                        Text(_borderRadius.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    Text('Vertical Offset'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                            valueIndicatorTextStyle: Theme.of(context)
                                .accentTextTheme
                                .body2
                                .copyWith(color: Colors.white),
                          ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _verticalOffset,
                            min: 0,
                            max: 0.5,
                            divisions: 10,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_verticalOffset',
                            onChanged: (a) {
                              setState(() {
                                _verticalOffset = a;
                              });
                            },
                          ),
                        ),
                        Text(_verticalOffset.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
