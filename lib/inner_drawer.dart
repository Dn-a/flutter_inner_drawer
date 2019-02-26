// InnerDrawer is based on Drawer.
// The source code of the Drawer has been re-adapted for Inner Drawer.

// more details:
// https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/drawer.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


/// Signature for the callback that's called when a [InnerDrawer] is
/// opened or closed.
typedef InnerDrawerCallback = void Function(bool isOpened);

/// The possible position of a [InnerDrawer].
enum InnerDrawerPosition
{
    start,
    end,
}

/// Animation type of a [InnerDrawer].
enum InnerDrawerAnimation
{
    static,
    linear,
    quadratic,
}


//width before initState
const double _kWidth = 400;
const double _kMinFlingVelocity = 365.0;
const double _kEdgeDragWidth = 20.0;
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
                          this.swipe = true,
                          this.boxShadow,
                          this.colorTransition,
                          this.animationType,
                          this.innerDrawerCallback,
                      }) : assert(child != null),assert(animationType != null),
            assert(position != null),assert(scaffold != null),
            super(key: key);
    
    
    final Widget child;
    
    /// A Scaffold is generally used but you are free to use other widgets
    final Widget scaffold;
    
    /// Offset drawer width; default 0.4
    final double offset;
    
    final bool onTapClose;
    
    /// activate or deactivate the swipe. NOTE: when deactivate, onTap Close is implicitly activated
    final bool swipe;
    
    /// BoxShadow of scaffold opened
    final List<BoxShadow> boxShadow;
    
    ///Color of gradient
    final Color colorTransition;
    
    /// This controls the direction in which the user should swipe to open and
    /// close the InnerDrawer.
    final InnerDrawerPosition position;
    
    /// Static or Linear
    final InnerDrawerAnimation animationType;
    
    /// Optional callback that is called when a [InnerDrawer] is opened or closed.
    final InnerDrawerCallback innerDrawerCallback;
    
    @override
    InnerDrawerState createState() => InnerDrawerState();
}


class InnerDrawerState extends State<InnerDrawer> with SingleTickerProviderStateMixin
{
    
    ColorTween _color = ColorTween(begin: Colors.transparent, end: Colors.black54);

    double _initWidth = _kWidth;
    Orientation _orientation = Orientation.portrait;
    
    @override
    void initState()
    {
        super.initState();

        _updateWidth();

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
        
        if(widget.colorTransition!=null)
            _color = ColorTween (begin: Colors.transparent, end: widget.colorTransition);
        else
            _color = ColorTween(begin: Colors.transparent, end: Colors.black54);
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
        //_ensureHistoryEntry();
    }
    
    
    /// currently not used
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
        return _initWidth;
    }

    /// get width of screen after initState
    void _updateWidth()
    {
        WidgetsBinding.instance.addPostFrameCallback((_){
            final RenderBox box = _drawerKey.currentContext?.findRenderObject();
            if (box != null && box.size!= null)
                setState(() {
                    _initWidth =  box.size.width;
                });
        });
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
    
    /// return widget with specific animation
    Widget _innerAnimationType(double width)
    {
        switch (widget.animationType) {
            case InnerDrawerAnimation.linear:
            case InnerDrawerAnimation.quadratic:
                return  Align(
                    alignment: _drawerOuterAlignment,
                    widthFactor: 1-(_controller.value/2),
                    child: Container(
                        width: _width - width,
                        height: MediaQuery.of(context).size.height,
                        ///when the animation is linear, the container is displayed when the animation completed
                        child: (_controller.value > 0 && widget.animationType == InnerDrawerAnimation.linear)? null: widget.child,
                    ),
                );
            case InnerDrawerAnimation.static:
                return Container(
                    width: _width - width,
                    height: MediaQuery.of(context).size.height,
                    child: widget.child,
                );
        }
        
    }
    
    /// Side swipe air
    Widget _trigger()
    {
        
        final bool drawerIsStart = widget.position == DrawerAlignment.start;
        final EdgeInsets padding = MediaQuery.of(context).padding;
        double dragAreaWidth = drawerIsStart ? padding.left : padding.right;
    
        if (Directionality.of(context) == TextDirection.rtl)
            dragAreaWidth = drawerIsStart ? padding.right : padding.left;
        dragAreaWidth = max(dragAreaWidth, _kEdgeDragWidth);
        
        if (_controller.status == AnimationStatus.completed && widget.swipe)
            return Align(
                alignment: _stackAlignment,
                child: Container(color:Colors.transparent, width: dragAreaWidth ),
            );
        else
            return null;
    }
    
    
    @override
    Widget build(BuildContext context)
    {
        //assert(debugCheckHasMaterialLocalizations(context));
    
        // initialize the correct width
        if(_initWidth == 400 || MediaQuery.of(context).orientation != _orientation)
            _updateWidth();
        _orientation = MediaQuery.of(context).orientation;
        
        double offset = widget.offset ?? 0.4;
        double wFactor = _controller.value;
        double width = (_width/2) -(_width/2)*offset;
        
        
        /// wFactor depends of offset and is used by the first Align that contains the Scaffold
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
            overflow: Overflow.visible,
            children: <Widget>[
                _innerAnimationType(width),
                GestureDetector(
                    key: _gestureDetectorKey,
                    onHorizontalDragDown: widget.swipe? _handleDragDown : null,
                    onHorizontalDragUpdate: widget.swipe? _move : null,
                    onHorizontalDragEnd: widget.swipe? _settle : null,
                    excludeFromSemantics: true,
                    child: RepaintBoundary(
                        child: Stack(
                            children: <Widget>[
                                BlockSemantics(
                                    child: GestureDetector(
                                        // On Android, the back button is used to dismiss a modal.
                                        excludeFromSemantics: defaultTargetPlatform == TargetPlatform.android,
                                        onTap: widget.onTapClose || !widget.swipe ? close:null,
                                        child: Semantics(
                                            //label: MaterialLocalizations.of(context)?.modalBarrierDismissLabel,
                                            child: Align(
                                                alignment: _drawerOuterAlignment,
                                                child: Container(
                                                    width: width,
                                                    color:Colors.transparent,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                                ///Gradient
                                Container(
                                    width: _controller.value==0 || widget.animationType == InnerDrawerAnimation.linear ? 0: null,
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
                                                        decoration: widget.animationType == InnerDrawerAnimation.linear ? null :
                                                        BoxDecoration(
                                                            boxShadow: widget.boxShadow ?? [
                                                                BoxShadow(
                                                                    color: Colors.black.withOpacity(0.5),
                                                                    blurRadius: 5,
                                                                    //spreadRadius: 0.1
                                                                )
                                                            ]
                                                        ),
                                                        child: Stack(
                                                            overflow: Overflow.visible,
                                                            children: <Widget>[
                                                                
                                                                /// Is displayed only when the Linear Animation is in progress, i have not found other ways
                                                                /// I adopted this technique because it seemed the only possible one
                                                                (widget.animationType==InnerDrawerAnimation.linear)?
                                                                Positioned(
                                                                    left: widget.position==InnerDrawerPosition.start? -(_width - width) : _width,
                                                                    right: widget.position==InnerDrawerPosition.end? -(_width - width) : _width,                                                                    child:Container(
                                                                        height: MediaQuery.of(context).size.height,
                                                                        child: (_controller.value==0)? null: widget.child,
                                                                    )
                                                                ) : null,
                                                                
                                                                ///Scaffold
                                                                widget.scaffold,
                                                                
                                                            ].where((a) => a != null ).toList(),
                                                        )
                                                    ),
                                                ),
                                            )
                                        ),
                                    ),
                                ),
                                ///Trigger
                                _trigger()
                            ].where((a) => a != null ).toList(),
                        ),
                    ),
                ),
            ],
        );
    }
    
}
