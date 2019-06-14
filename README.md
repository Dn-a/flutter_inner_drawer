# flutter_inner_drawer
[![pub package](https://img.shields.io/badge/pub-0.2.7-orange.svg)](https://pub.dartlang.org/packages/flutter_inner_drawer)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter#drawers)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/dnag88)


Inner Drawer is an easy way to create an internal side section (left/right) where you can insert a list menu or other.

## Installing
Add this to your package's pubspec.yaml file:
```dart
dependencies:
  flutter_inner_drawer: "^0.2.7"
```
## Demo
<div align="center">
  <table><tr>
<td style="text-align:center">
  <img width="250px"  src="https://github.com/Dn-a/flutter_inner_drawer/blob/master/example/example3.gif?raw=true" />
 </td>
<td style="text-align:center">
  <img width="250px"  src="https://github.com/Dn-a/flutter_inner_drawer/blob/master/example/pic.png?raw=true"/>
 </td>
 </tr></table>
</div>


### Simple usage
```dart
import 'package:flutter_inner_drawer/inner_drawer.dart';
.
.
.

    final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();


    @override
    Widget build(BuildContext context)
    {
        return InnerDrawer(
            key: _innerDrawerKey,
            position: InnerDrawerPosition.start, // required
            onTapClose: true, // default false
            swipe: true, // default true
            offset: 0.6, // default 0.4
            colorTransition: Color.red, // default Color.black54
            animationType: InnerDrawerAnimation.linear, // default static
            innerDrawerCallback: (a) => print(a), // return bool
            child: Material(
                child: SafeArea(
                    child: Container(...)
                )
            ),
            //  A Scaffold is generally used but you are free to use other widgets
            // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
            scaffold: Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false
                )
                .
                .
            ) 
            or 
            CupertinoPageScaffold(                
                navigationBar: CupertinoNavigationBar(
                    automaticallyImplyLeading: false
                ),
                .
                .
            ), 
        )
    }
    
    void _open()
    {
       _innerDrawerKey.currentState.open();
    }
    
    void _close()
    {
       _innerDrawerKey.currentState.close();
    }

```

### All parameters
* child - *Inner Widget (required)*
* scaffold - *A Scaffold is generally used but you are free to use other widgets (required)*
* position - *This controls the direction in which the user should swipe to open and close the InnerDrawer (required)*
* offset - *Offset drawer width (default 0.4)*
* onTapClose - *bool (default false)*
* swipe - *bool (default true)*
* boxShadow - *BoxShadow of scaffold opened*
* colorTransition - *default Colors.black54*
* animationType - *static / linear / quadratic (default static)*
* innerDrawerCallback - *Optional callback that is called when a InnerDrawer is opened or closed*

## Donate
If you found this project helpful or you learned something from the source code and want to thank me: 
- [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/dnag88)

## Issues
If you encounter problems, open an issue. Pull request are also welcome.