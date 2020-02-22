import 'dart:ui';

import 'package:example/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ExampleOne extends StatefulWidget {
  ExampleOne({Key key}) : super(key: key);

  @override
  _ExampleOneState createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne>
    with SingleTickerProviderStateMixin {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;

  bool _position = true;
  bool _onTapToClose = false;
  bool _swipe = true;
  bool _tapScaffold = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;

  double _dragUpdate = 0;

  InnerDrawerDirection _direction = InnerDrawerDirection.start;

  String _title = "One";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: _onTapToClose,
      tapScaffoldEnabled: _tapScaffold,
      leftOffset: _offset,
      rightOffset: _offset,
      swipe: _swipe,
      boxShadow: _direction == InnerDrawerDirection.start &&
              _animationType == InnerDrawerAnimation.linear
          ? []
          : null,
      colorTransition: currentColor,
      leftAnimationType: _animationType,
      rightAnimationType: InnerDrawerAnimation.linear,

      leftChild: Material(
          child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                //stops: [0.1, 0.5,0.5, 0.7, 0.9],
                colors: [
                  ColorTween(
                    begin: Colors.blueAccent,
                    end: Colors.blueGrey[400].withRed(100),
                  ).lerp(_dragUpdate),
                  ColorTween(
                    begin: Colors.green,
                    end: Colors.blueGrey[800].withGreen(80),
                  ).lerp(_dragUpdate),
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 15),
                            width: 80,
                            child: ClipRRect(
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrWfWLnxIT5TnuE-JViLzLuro9IID2d7QEc2sRPTRoGWpgJV75",
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Text(
                            "User",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                        //mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      ListTile(
                        onTap: () => print("Dashboard"),
                        title: Text(
                          "Dashboard",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Nametag",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.rounded_corner,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Favorite",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.bookmark_border,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Close Friends",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.list,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Suggested People",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.person_add,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.all_out,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          " LogOut",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          _dragUpdate < 1
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: (10 - _dragUpdate * 10),
                      sigmaY: (10 - _dragUpdate * 10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                )
              : null,
        ].where((a) => a != null).toList(),
      )),

      rightChild: Material(
          child: SafeArea(
              //top: false,
              child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.grey[200]),
              right: BorderSide(width: 1, color: Colors.grey[200])),
        ),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircleAvatar(
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 12),
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            Text(
                              "   Guest",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, height: 1.2),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2, right: 25),
                          child: GestureDetector(
                            child: Icon(
                              _position
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              size: 18,
                            ),
                            onTap: () {
                              _innerDrawerKey.currentState.toggle();
                            },
                          ),
                        ),
                      ],
                    )),
                Divider(),
                ListTile(
                  title: Text("Statistics"),
                  leading: Icon(Icons.show_chart),
                ),
                ListTile(
                  title: Text("Activity"),
                  leading: Icon(Icons.access_time),
                ),
                ListTile(
                  title: Text("Nametag"),
                  leading: Icon(Icons.rounded_corner),
                ),
                ListTile(
                  title: Text("Favorite"),
                  leading: Icon(Icons.bookmark_border),
                ),
                ListTile(
                  title: Text("Close Friends"),
                  leading: Icon(Icons.list),
                ),
                ListTile(
                  title: Text("Suggested People"),
                  leading: Icon(Icons.person_add),
                ),
                ListTile(
                  title: Text("Open Facebook"),
                  leading: Icon(
                    Env.facebook_icon,
                    size: 18,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  //width: double.maxFinite,
                  decoration: BoxDecoration(
                      //color: Colors.grey,
                      border: Border(
                          top: BorderSide(
                    color: Colors.grey[300],
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        size: 18,
                      ),
                      Text(
                        "  Settings",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ))),

      scaffold: Container(
          decoration: BoxDecoration(
            /*gradient: RadialGradient(
                        center: const Alignment(0.0, -0.0), // near the top right
                        radius: 0.8,
                        colors: [
                            const Color(0xFFFFFF00), // yellow sun
                            const Color(0xFF0099FF), // blue sky
                        ],
                        stops: [0.1, 1.0],
                    ),*/
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              //stops: [0.1, 0.5,0.5, 0.7, 0.9],
              colors: [
                ColorTween(
                  begin: Colors.blueAccent,
                  end: Colors.blueGrey[400].withRed(100),
                ).lerp(_dragUpdate),
                ColorTween(
                  begin: Colors.green,
                  end: Colors.blueGrey[800].withGreen(80),
                ).lerp(_dragUpdate),
              ],
            ),
          ),
          child: SafeArea(
              child: Material(
            color: Colors.transparent,
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.grey[100]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Animation Type",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Text('Static'),
                              Checkbox(
                                  activeColor: Colors.black,
                                  value: _animationType ==
                                      InnerDrawerAnimation.static,
                                  onChanged: (a) {
                                    setState(() {
                                      _animationType =
                                          InnerDrawerAnimation.static;
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
                                  value: _animationType ==
                                      InnerDrawerAnimation.linear,
                                  onChanged: (a) {
                                    setState(() {
                                      _animationType =
                                          InnerDrawerAnimation.linear;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                  activeColor: Colors.black,
                                  value: _swipe,
                                  onChanged: (a) {
                                    setState(() {
                                      _swipe = !_swipe;
                                    });
                                  }),
                              Text('Swipe'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _swipe = !_swipe;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                  activeColor: Colors.black,
                                  value: _tapScaffold,
                                  onChanged: (a) {
                                    setState(() {
                                      _tapScaffold = !_tapScaffold;
                                    });
                                  }),
                              Text('TapScaffoldEnabled'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _tapScaffold = !_tapScaffold;
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.black,
                              value: _onTapToClose,
                              onChanged: (a) {
                                setState(() {
                                  _onTapToClose = !_onTapToClose;
                                });
                              }),
                          Text('OnTap To Close'),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _onTapToClose = !_onTapToClose;
                        });
                      },
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
                    Padding(padding: EdgeInsets.all(10)),
                    FlatButton(
                      child: Text(
                        "Set Color Transition",
                        style: TextStyle(
                            color: currentColor, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: changeColor,
                                  //enableLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Set'),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                      },
                    ),
                    Padding(padding: EdgeInsets.all(25)),
                    RaisedButton(
                      child: Text("open"),
                      onPressed: () {
                        // direction is optional
                        // if not set, the last direction will be used
                        _innerDrawerKey.currentState.toggle();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ))),

      onDragUpdate: (double val, InnerDrawerDirection direction) {
        _direction = direction;
        setState(() => _dragUpdate = val);
      },
      //innerDrawerCallback: (a) => print(a),
    );
  }
}
