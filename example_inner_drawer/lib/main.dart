import 'package:example_inner_drawer/end.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/flutter_inner_drawer.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget
{
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inner Drawer',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Flutter Inner Drawer'),
    );
  }
}


class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
{
    final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

    bool _position = true;
    bool _onTapToClose = false;
    

    @override
    Widget build(BuildContext context)
    {
    
        return InnerDrawer(
            key: _innerDrawerKey,
            position: _position ? InnerDrawerPosition.start : InnerDrawerPosition.end,
            onTapClose: _onTapToClose,
            //offset: 0.4,
            //innerDrawerCallback: (a) => print(a),
            child: Material(
                //color: Colors.blueGrey,
                child:  SafeArea(
                    //top: false,
                    child: ListView(
                        children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top:10, left: 15),
                                child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                        SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircleAvatar(
                                                child: Icon(Icons.person,color: Colors.white,size: 12),
                                                backgroundColor: Colors.grey,
                                            ),
                                        ),
                                        Text("   Guest",
                                            style: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
                                        ),
                                    ],
                                )
                            ),
                            Divider(),
                            ListTile(
                                title:  Text("Statistics"),
                                leading:Icon(Icons.show_chart),
                            ),
                            ListTile(
                                title:   Text("Activity"),
                                leading: Icon(Icons.access_time),
                            ),
                            ListTile(
                                title:   Text("Nametag"),
                                leading: Icon(Icons.rounded_corner),
                            ),
                            ListTile(
                                title:   Text("Favorite"),
                                leading: Icon(Icons.bookmark_border),
                            ),
                            ListTile(
                                title:   Text("Close Friends"),
                                leading: Icon(Icons.list),
                            ),
                            ListTile(
                                title:   Text("Suggested People"),
                                leading: Icon(Icons.person_add),
                            ),
                            ListTile(
                                title:   Text("Open Facebook"),
                                leading: Icon(Env.facebook_icon,size: 18,),
                            )
                        ],
                    )
                )
            ),
            scaffold: Scaffold(
                drawer: Drawer(),
                appBar: AppBar(
                    title: Text(widget.title),
                    //automaticallyImplyLeading: false, // recommended, disable the closing icon
                    backgroundColor: Colors.grey[50],
                ),
                body: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                GestureDetector(
                                    child: Row(
                                        children: <Widget>[
                                            Icon(Icons.arrow_back,size: 15,),
                                            Text('Start'),
                                            Checkbox(
                                                value: _position,
                                                onChanged: (a){
                                                    setState(() {
                                                        _position = true;
                                                    });
                                                }
                                            ),
                                        ],
                                    ),
                                    onTap: (){
                                        setState(() {
                                            _position = true;
                                        });
                                    },
                                ),
                                GestureDetector(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            Checkbox(
                                                value: !_position,
                                                onChanged: (a){
                                                    setState(() {
                                                        _position = false;
                                                    });
                                                }
                                            ),
                                            Text('End'),
                                            Icon(Icons.arrow_forward,size: 15,),
                                        ],
                                    ),
                                    onTap: (){
                                        setState(() {
                                            _position = false;
                                        });
                                    },
                                ),
                            ],
                        ),
                        GestureDetector(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Checkbox(
                                        value: _onTapToClose,
                                        onChanged: (a){
                                            setState(() {
                                                _onTapToClose = !_onTapToClose;
                                            });
                                        }
                                    ),
                                    Text('On Tap To Close'),
                                ],
                            ),
                            onTap: (){
                                setState(() {
                                    _onTapToClose = !_onTapToClose;
                                });
                            },
                        ),
                        Padding(
                            padding: EdgeInsets.all(25)
                        ),
                        RaisedButton(
                            child:Text("open"),
                            onPressed: (){
                                _innerDrawerKey.currentState.open();
                            },
                        )
                        ],
                    ),
                ),
            
            ),
            );
        }
    
}
