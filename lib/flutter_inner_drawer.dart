import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


typedef InnerDrawerCallback = void Function(bool isOpened);


enum InnerDrawerPosition
{
  start,
  end,
}

const double _kWidth = 304.0;
const double _kEdgeDragWidth = 20.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);



class InnerDrawer extends StatefulWidget
{
 
  const InnerDrawer({
                           GlobalKey key,
                           @required this.child,
                           @required this.scaffold,
                           @required this.position,
                           this.offset,
                           this.onTapClose = false,
                           this.boxShadow,
                           this.innerDrawerCallback,
                         }) : assert(child != null),
        assert(position != null),
        super(key: key);
  
 
  final Widget child;
  final Widget scaffold;
  final double offset;
  final bool onTapClose;
  final List<BoxShadow> boxShadow;
  final InnerDrawerPosition position;
  final InnerDrawerCallback innerDrawerCallback;
  
  @override
  InnerDrawerState createState() => InnerDrawerState();
}


class InnerDrawerState extends State<InnerDrawer> with SingleTickerProviderStateMixin
{
  
  
  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController(duration: _kBaseSettleDuration, vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
    
    _controller.value = 1;
  }
  
  
  @override
  void dispose()
  {
    _historyEntry?.remove();
    _controller.dispose();
    super.dispose();
  }
  
  
  void _animationChanged()
  {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
  }
  
  
  LocalHistoryEntry _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  
  
  void _ensureHistoryEntry()
  {
    if (_historyEntry == null) {
      final ModalRoute<dynamic> route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }
  
  
  void _animationStatusChanged(AnimationStatus status)
  {
    switch (status) {
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.forward:
        _historyEntry?.remove();
        _historyEntry = null;
        break;
      case AnimationStatus.dismissed:
          _ensureHistoryEntry();
        break;
      case AnimationStatus.completed:
        break;
    }
  }
  
  
  void _handleHistoryEntryRemoved()
  {
    _historyEntry = null;
    close();
  }
  
  
  AnimationController _controller;
  
  
  void _handleDragDown(DragDownDetails details)
  {
    _controller.stop();
    _ensureHistoryEntry();
  }
  
  
  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating )
      return;
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }
  
  
  final GlobalKey _drawerKey = GlobalKey();
  
  
  double get _width
  {
    final RenderBox box = _drawerKey.currentContext?.findRenderObject();
    if (box != null)
      return box.size.width;
    return _kWidth; // drawer not being shown currently
  }
  
  
  bool _previouslyOpened = false;
  
  
  void _move(DragUpdateDetails details)
  {
    double delta = details.primaryDelta / _width;
    
    switch (widget.position) {
      case InnerDrawerPosition.end:
        break;
      case InnerDrawerPosition.start:
        delta = -delta;
        break;
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }
    
    final bool opened = _controller.value > 0.5 ? true : false;
    if (opened != _previouslyOpened && widget.innerDrawerCallback != null)
      widget.innerDrawerCallback(opened);
    _previouslyOpened = opened;
  }
  
  
  void _settle(DragEndDetails details)
  {
    if (_controller.isDismissed)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
     
      switch (widget.position) {
        case InnerDrawerPosition.end:
          break;
        case InnerDrawerPosition.start:
          visualVelocity = -visualVelocity;
          break;
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
      }
    } else if (_controller.value < 0.5) {
      open();
    } else {
      close();
    }
  }
  
 
  void open()
  {
    _controller.fling(velocity: -1);
    if (widget.innerDrawerCallback != null)
      widget.innerDrawerCallback(true);
  }
  
 
  void close()
  {
    _controller.fling(velocity:1);
    if (widget.innerDrawerCallback != null)
      widget.innerDrawerCallback(false);
  }
  
  
  final ColorTween _color = ColorTween(begin: Colors.transparent, end: Colors.black54);
  final GlobalKey _gestureDetectorKey = GlobalKey();
  
  
    AlignmentDirectional get _drawerOuterAlignment
    {
        assert(widget.position != null);
        switch (widget.position) {
          case InnerDrawerPosition.start:
            return AlignmentDirectional.centerEnd;
          case InnerDrawerPosition.end:
            return AlignmentDirectional.centerStart;
        }
        return null;
    }
  
    
    AlignmentDirectional get _drawerInnerAlignment
    {
        assert(widget.position != null);
        switch (widget.position) {
          case InnerDrawerPosition.start:
            return AlignmentDirectional.centerStart;
          case InnerDrawerPosition.end:
            return AlignmentDirectional.center;
        }
        return null;
    }

    AlignmentDirectional get _stackAlignment
    {
          assert(widget.position != null);
          switch (widget.position) {
              case InnerDrawerPosition.start:
                  return AlignmentDirectional.centerStart;
              case InnerDrawerPosition.end:
                  return AlignmentDirectional.centerEnd;
          }
          return null;
    }
  
  
    @override
    Widget build(BuildContext context)
    {
        // print(_controller.value);
        assert(debugCheckHasMaterialLocalizations(context));
        
        double offset = widget.offset ?? 0.4;
        double wFactor = _controller.value;
        double width = (_width/2) -(_width/2)*offset;
        
        switch (widget.position) {
            case InnerDrawerPosition.start:
                wFactor += offset;
                break;
            case InnerDrawerPosition.end:
                wFactor += (1 - offset);
                break;
        }
        
        return Stack(
            alignment: _stackAlignment,
            children: <Widget>[
                Container(
                    width: _width - width,
                    height: double.infinity,
                    child: widget.child,
                ),
                GestureDetector(
                    key: _gestureDetectorKey,
                    onHorizontalDragDown: _handleDragDown,
                    onHorizontalDragUpdate: _move,
                    onHorizontalDragEnd: _settle,
                    //onHorizontalDragCancel: _handleDragCancel,
                    excludeFromSemantics: true,
                    child: RepaintBoundary(
                        child: Stack(
                            children: <Widget>[
                                BlockSemantics(
                                    child: GestureDetector(
                                        // On Android, the back button is used to dismiss a modal.
                                        excludeFromSemantics: defaultTargetPlatform == TargetPlatform.android,
                                        onTap: widget.onTapClose ?close:null,
                                        child: Semantics(
                                            label: MaterialLocalizations.of(context)?.modalBarrierDismissLabel,
                                            child: Align(
                                                alignment: _drawerOuterAlignment,
                                                child: Container(
                                                    width: width,
                                                    color:Colors.red,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                                Container(
                                    width: _controller.value==0?0:null,
                                    color: _color.evaluate(_controller),
                                ),
                                Align(
                                    widthFactor:  wFactor,
                                    child: Align(
                                        alignment: _drawerOuterAlignment,
                                        child: Align(
                                            alignment: _drawerInnerAlignment,
                                            widthFactor: _controller.value,
                                            child: RepaintBoundary(
                                                child: FocusScope(
                                                    key: _drawerKey,
                                                    node: _focusScopeNode,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: widget.boxShadow ?? [
                                                                BoxShadow(
                                                                    color: Colors.black.withOpacity(0.5),
                                                                    blurRadius: 5,
                                                                    //spreadRadius: 0.1
                                                                )
                                                            ]
                                                        ),
                                                        child: widget.scaffold
                                                    ),
                                                ),
                                            )
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
                /*Align(
                    //right:  right,
                    //height: MediaQuery.of(context).size.height,
                    //width:  MediaQuery.of(context).size.width,
                    alignment: AlignmentDirectional.center,
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        widthFactor: _controller.value+0.1,
                        child: GestureDetector(
                            key: _gestureDetectorKey,
                            onHorizontalDragDown: _handleDragDown,
                            onHorizontalDragUpdate: _move,
                            onHorizontalDragEnd: _settle,
                            onHorizontalDragCancel: _handleDragCancel,
                            excludeFromSemantics: true,
                            /*onHorizontalDragStart: (tap) {
                                print(tap.globalPosition.dx);
                                setState(() {
                                    _start =tap.globalPosition.dx ;
                                });
                            },
                            onHorizontalDragEnd: (a){
                                setState(() {
                                    _end = _left;
                                });
                            },
                            onHorizontalDragUpdate: (up) {
                                //print(up.globalPosition.dx);
                                setState(() {
                                    _left = up.globalPosition.dx;
                                });
                            },*/
              
                            child:  RepaintBoundary(
                                child: FocusScope(
                                    key: _drawerKey,
                                    node: _focusScopeNode,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black.withOpacity(0.75),
                                                    blurRadius: 4,
                                                    spreadRadius: 1
                                                )
                                            ]
                                        ),
                                        child: widget.scaffold
                                    ),
                                ),
                            )
                        )
                    )
                ),*/
            ],
        );
    }
  
}
