import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import '../env.dart';

class RightChild extends StatelessWidget {
  final bool _position = true;
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  RightChild({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build right");

    return Material(
        child: SafeArea(
            //top: false,
            right: false,
            left: false,
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
                          padding:
                              EdgeInsets.only(top: 12, bottom: 4, left: 15),
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
                                        fontWeight: FontWeight.w600,
                                        height: 1.2),
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
                                    innerDrawerKey.currentState.toggle();
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
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
            )));
  }
}
