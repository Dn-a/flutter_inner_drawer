# flutter_inner_drawer
[![pub package](https://img.shields.io/badge/pub-0.5.0-orange.svg)](https://pub.dartlang.org/packages/flutter_inner_drawer)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter#drawers)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/dnag88)


Inner Drawer is an easy way to create an internal side section (left/right) where you can insert a list menu or other.

## Installing
Add this to your package's pubspec.yaml file:
```dart
dependencies:
  flutter_inner_drawer: "^0.5.0"
```
## Demo
<div align="center">
  <table><tr>
 <td style="text-align:center">
  <img width="250px"  src="https://github.com/Dn-a/flutter_inner_drawer/raw/master/repo-files/img/example5.1.gif?" />
 </td>
 <td style="text-align:center">
   <img width="250px"  src="https://github.com/Dn-a/flutter_inner_drawer/raw/master/repo-files/img/example5.2.gif?" />
 </td>
 </tr></table>
</div>


### Simple usage
```dart
import 'package:flutter_inner_drawer/inner_drawer.dart';
.
.
.
    //  Current State of InnerDrawerState
    final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();


    @override
    Widget build(BuildContext context)
    {
        return InnerDrawer(
            key: _innerDrawerKey,
            onTapClose: true, // default false
            swipe: true, // default true            
            colorTransition: Color.red, // default Color.black54            
            leftOffset: 0.6, // default 0.4
            rightOffset: 0.6,// default 0.4
            leftScale: 0.9,// default 1
            rightScale: 0.9,// default 1
            borderRadius: 50, // default 0
            leftAnimationType: InnerDrawerAnimation.static, // default static
            rightAnimationType: InnerDrawerAnimation.quadratic,
            
            //when a pointer that is in contact with the screen and moves to the right or left            
            onDragUpdate: (double val, InnerDrawerDirection direction) {
                // return values between 1 and 0
                print(val);
                // check if the swipe is to the right or to the left
                print(direction==InnerDraweDirection.start);
            },
            
            innerDrawerCallback: (a) => print(a), // return  true (open) or false (close)
            leftChild: Container(), // required if rightChild is not set
            rightChild: Container(), // required if leftChild is not set
            
            //  A Scaffold is generally used but you are free to use other widgets
            // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
            scaffold: Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false
                ),
            ) 
            OR
            CupertinoPageScaffold(                
                navigationBar: CupertinoNavigationBar(
                    automaticallyImplyLeading: false
                ),
            ), 
        )
    }
    
    void _toggle()
    {
       _innerDrawerKey.currentState.toggle(
       // direction is optional 
       // if not set, the last direction will be used
       //InnerDrawerDirection.start OR InnerDrawerDirection.end                        
        direction: InnerDrawerDirection.end 
       );
    }
    
    

```

### InnerDrawer Parameters
|PropName|Description|default value|
|:-------|:----------|:------------|
|`scaffold`|*A Scaffold is generally used but you are free to use other widgets*|required|
|`leftChild`|*Inner Widget*|required if rightChild is not set|
|`rightChild`|*Inner Widget*|required if leftChild is not set|
|`leftOffset`|*Offset drawer width*|0.4|
|`rightOffset`|*Offset drawer width*|0.4|
|`leftScale`|*Left scaffold scaling*|1|
|`rightScale`|*Right scaffold scaling*|1|
|`borderRadius`|*For scaffold border*|0|
|`onTapClose`|*Tap on the Scaffold closes it*|false|
|`swipe`|*activate or deactivate the swipe*|true|
|`tapScaffoldEnabled`|*Possibility to tap the scaffold even when open*|false|
|`boxShadow`|*BoxShadow of scaffold opened*|[BoxShadow(color: Colors.black.withOpacity(0.5),blurRadius: 5)]|
|`colorTransition`|*Change background color while swiping*|Colors.black54|
|`leftAnimationType`|*static / linear / quadratic*|static|
|`rightAnimationType`|*static / linear / quadratic*|static|
|`innerDrawerCallback`|*Optional callback that is called when a InnerDrawer is opened or closed*||
|`onDragUpdate`|*When a pointer that is in contact with the screen and moves to the right or left*||
|`_innerDrawerKey.currentState.open`|*Current State of GlobalKey<InnerDrawerState>(check example) - OPEN*||
|`_innerDrawerKey.currentState.close`|*Current State of GlobalKey<InnerDrawerState>(check example) - CLOSE*||
|`_innerDrawerKey.currentState.toggle`|*Current State of GlobalKey<InnerDrawerState>(check example) - OPEN or CLOSE*||

## Donate
If you found this project helpful or you learned something from the source code and want to thank me: 
- [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/dnag88)

## Issues
If you encounter problems, open an issue. Pull request are also welcome.
