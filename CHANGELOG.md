## [1.0.0+1] - 2021-03-17.

* [Fixed] - Improvement null safety support.

## [1.0.0] - 2021-03-17.

* [Updated] - Migrate to stable null safety.

## [0.5.8] - 2021-03-17.

* [Updated] - Flutter 2.0 support.
* [Updated] - example 1.

## [0.5.7+2] - 2020-08-05.

* [Clean] - deprecated functions.
* [Updated] - example 1.
* [Fixed] - issues #43, #47.

## [0.5.7+1] - 2020-07-31.

* [Updated] - Readme.

## [0.5.7] - 2020-07-31.

* [Added] - swipeChild which allows swiping scaffold from left/right child.
* [Fixed] - issue #45.
* [Replaced] - `boxDecoration` with `decoration`.
* [Updated] - Readme.

## [0.5.6+1] - 2020-05-14.

* Update Documentation.
* general improvements.
* `backgroundColor` field replaced by `backgroundDecoration` (BoxDecoration).

## [0.5.6] - 2020-05-13.

* Update Documentation.
* Added `velocity` field. Allows you to set the opening and closing velocity when using the open/close methods.
* `colorTransition` field renamed to `colorTransitionChild`.
* Added `colorTransitionScaffold` field.

## [0.5.5+3] - 2020-04-29.

* Rollback issue #33.
* Fixed some problems.

## [0.5.5+2] - 2020-04-28.

* general improvements.

## [0.5.5+1] - 2020-04-28.

* Fixed issues : #30 and #33.

## [0.5.5] - 2020-03-07.

* Update Documentation.

## [0.5.4] - 2019-12-07.

* Update Readme.

## [0.5.3] - 2019-12-07.

* **new Features and Documentation Updates**
*
* Added `IDOffset` class. An immutable set of offset in each of the four cardinal directions. 
* Added `offset` field. `leftOffset` and `rightOffset` Deprecated.
* Added `scale` field. `leftScale` and `rightScale` Deprecated.
* Added `duration` field. Duration of AnimationController.
* Cleaning code.
* Update Readme.

## [0.5.2] - 2019-11-15.

* **General improvement of the code**
*
* Added `backgroundColor` field.
* Fixed some problems related to swipe and scaleFactor.
* Cleaning code.
* Update Readme.

## [0.5.1] - 2019-11-09.

* **General improvement of the code**
*
* Added `proportionalChildArea`. if == true dynamically sets the width based on the selected offset, otherwise it leaves the width at 100% of the screen.
* Possibility to set `boxShadow` also for linear animation.
* When `borderSide` > 0, `boxShadow` did not work.
* Cleaning code.
* Update Readme.

## [0.5.0] - 2019-10-16.

* **new Features and Documentation Updates**
*
* Added `borderRadius` field for scaffold border - (double value).
* Added `leftScale` and  `RightScale` fields for scaffold scaling - (double value).
* Added `onDragUpdate(double value, InnerDraweDirection direction)` callback function.

## [0.4.0] - 2019-08-07.

* **new Features and Documentation Updates**
*
* Parameter `position` removed. Now it is possible to define `leftChild` and `rightChild` simultaneously.
* Parameter `offset` replaced with `leftOffset` and `rightOffset`.
* Parameter `animationType` replaced with `leftAnimationType` and `rightAnimationType`.
* Possibility to tap the scaffold even when open with `tapScaffoldEnabled`. 

## [0.3.0] - 2019-07-07.

* General improvement of the code.

## [0.2.9] - 2019-06-20.

* Updated dependencies.
* Added toggle method.

## [0.2.8] - 2019-06-14.

* fixed history.

## [0.2.7] - 2019-06-14.

* Cleaning code.
* Update Readme.

## [0.2.6] - 2019-05-13.

* Fixed InnerDrawerCallback.

## [0.2.5] - 2019-04-19.

* General improvement of the code.

## [0.2.4] - 2019-04-16.

* Fixed swipe precision.

## [0.2.3] - 2019-04-06.

* fixed some problem.
* General improvement of the code.

## [0.2.2] - 2019-02-26.

* fixed some artifacts with linear animation.

## [0.2.1] - 2019-02-25.

* solved the problem of CupertinoThemeData that launched an assert.

## [0.2.0] - 2019-02-16.

* 3 types of animation (static - linear - quadratic) 
* Improved documentation.

## [0.1.5] - 2019-02-13.

* Improved documentation.

## [0.1.4] - 2019-02-13.

* Improved documentation.

## [0.1.3] - 2019-02-13.

* fixed swipe.

## [0.1.2] - 2019-02-13.

* Added side trigger - Possibility to activate/deactivate the swipe.

## [0.1.1] - 2019-02-12.

* Improved documentation.

## [0.1.0] - 2019-02-12.

* Improved documentation - General improvement of the code.

## [0.0.1] - 2019-02-12.

* Created Inner Drawer.
