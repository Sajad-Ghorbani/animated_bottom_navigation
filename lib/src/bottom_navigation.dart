import 'dart:async';
import 'dart:ui';

import 'package:animated_bottom_navigation/src/animated_item.dart';
import 'package:animated_bottom_navigation/src/item.dart';
import 'package:animated_bottom_navigation/src/item_children.dart';
import 'package:flutter/material.dart';

/// Function type that takes an integer value and returns a boolean.
typedef LetIndexPage = bool Function(int value);

/// The [AnimatedBottomNavigation] widget.
class AnimatedBottomNavigation extends StatefulWidget {
  AnimatedBottomNavigation({
    Key? key,
    required this.context,
    required this.items,
    this.onChanged,
    LetIndexPage? letIndexChange,
    this.width = 30,
    this.backgroundColor = Colors.white,
    this.backgroundGradient,
    this.direction,
    this.animationCurve = Curves.easeIn,
    this.height = 75.0,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(20)),
    this.horizontalPadding = 20.0,
    this.margin,
    this.animationDuration = const Duration(milliseconds: 200),
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  /// BuildContext for use in obtaining distances
  final BuildContext context;

  /// List of TabItem for show icons.
  /// Ensure that the 'items' list is not empty
  final List<TabItem> items;

  /// Function which takes page index as argument and returns bool.
  ///
  /// If function returns false then page is not changed on button tap. It returns true by default
  final LetIndexPage letIndexChange;

  /// Callback function that is called when the selected tab changes
  final ValueChanged<int>? onChanged;

  /// Color of NavigationBar's background, default Colors.white
  final Color backgroundColor;

  /// Background gradient for the widget
  final Gradient? backgroundGradient;

  /// Direction of app to handle rotate and layout, default TextDirection.ltr
  final TextDirection? direction;

  /// Curves interpolating button change animation, default Curves.easeIn
  final Curve animationCurve;

  /// Height of NavigationBar, min 0.0, max 75.0
  final double height;

  /// Duration of button change animation, default Duration(milliseconds: 150)
  final Duration animationDuration;

  /// The amount of curvature in the upper edges, default 20.0
  final BorderRadiusGeometry? borderRadius;

  /// The amount of distance from the surroundings, default 20.0
  final double horizontalPadding;

  /// Margin for the widget
  final EdgeInsetsGeometry? margin;

  /// Width of any widget in NavigationBar, default 40.0
  final double width;

  @override
  State<AnimatedBottomNavigation> createState() =>
      _AnimatedBottomNavigationState();
}

/// The state of the [AnimatedBottomNavigation] widget.
class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation> {
  late double _slideOffset;
  late int _length;
  late double _constWidth;
  late TextDirection _direction;
  List<Map<int, double>> offsetList = [];
  List<Map<int, bool>> showItems = [];
  List<bool> showChildren = [];
  List<bool> itemSelected = [];
  List<bool> onItemsTapped = [];
  List<bool> showItemsSpace = [];
  late double rightPadding;
  late double leftPadding;

  @override
  void initState() {
    super.initState();
    _direction = widget.direction ?? Directionality.of(widget.context);
    rightPadding = widget.horizontalPadding;
    leftPadding = widget.horizontalPadding;
    for (int i = 0; i < widget.items.length; i++) {
      offsetList.add({i: 0});
      showItems.add({i: true});
      showChildren.add(false);
      itemSelected.add(false);
      onItemsTapped.add(false);
      showItemsSpace.add(false);
    }
    _length = widget.items.length;
    _constWidth = (MediaQuery.of(widget.context).size.width -
            (widget.horizontalPadding * 2) -
            (widget.margin != null ? widget.margin!.collapsedSize.width : 0) -
            (widget.width * _length)) /
        (_length - 1);
    _slideOffset = _direction == TextDirection.rtl ? -1.1 : 1.1;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _closeItems();
      },
      child: TapRegion(
        onTapOutside: (event) {
          _closeItems();
        },
        child: Container(
          margin: widget.margin,
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: widget.backgroundColor,
                  gradient: widget.backgroundGradient,
                ),
                padding:
                    EdgeInsets.only(right: rightPadding, left: leftPadding),
                height: widget.height,
                child: Directionality(
                  textDirection: _direction,
                  child: _body(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The body of the [AnimatedBottomNavigation] widget.
  Widget _body() {
    return Row(
      children: widget.items.map((item) {
        int index = widget.items.indexOf(item);
        return Row(
          children: [
            if (showItems[index][index]!)
              AnimatedItem(
                iconOffset: Offset(0, offsetList[index][index]!),
                iconSelected: itemSelected[index],
                icon: item.icon,
                spaceWidth: _constWidth,
                haveChildren: item.haveChildren,
                width: widget.width,
                direction: _direction,
                index: index,
                isFirstChild: index == 0,
                curve: widget.animationCurve,
                showSpaceAfterIcon: index != widget.items.length - 1,
                duration: widget.animationDuration,
                activeColor: item.activeColor,
                inActiveColor: item.inActiveColor,
                childrenCount: item.children?.length,
                isTapped: onItemsTapped[index],
                showSpace: showItemsSpace[index],
                onTap: () async {
                  setState(() {
                    onItemsTapped[index] = !onItemsTapped[index];
                  });
                  setState(() {
                    if (index == widget.items.length - 1) {
                      if (widget.direction == TextDirection.rtl) {
                        rightPadding = widget.horizontalPadding - 7;
                      } //
                      else {
                        leftPadding = widget.horizontalPadding - 7;
                      }
                    }
                  });
                  await _onTap(item, index);
                  if (item.haveChildren) {
                    Future.delayed(widget.animationDuration, () async {
                      _callBack(index);
                    });
                    Future.delayed(widget.animationDuration, () {
                      setState(() {
                        showItemsSpace[index] = true;
                      });
                    });
                  }
                },
                callback: () {
                  _callBack(index);
                },
                onReverseTap: () {
                  _closeItems();
                },
              ),
            if (showChildren[index] == true)
              ItemChildren(
                offset: Offset(_slideOffset, 0),
                width: widget.width,
                context: context,
                curve: widget.animationCurve,
                padding: widget.horizontalPadding,
                margin: widget.margin != null
                    ? widget.margin!.collapsedSize.width
                    : 0,
                duration: widget.animationDuration,
                children: item.children!,
              ),
          ],
        );
      }).toList(),
    );
  }

  /// Sets the current page.
  void _setPage(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(index);
    }
  }

  /// Called when an item is tapped.
  Future<void> _onTap(TabItem item, int index) async {
    Future.delayed(
        Duration(milliseconds: widget.animationDuration.inMilliseconds * 2),
        () {
      if (widget.onChanged != null) {
        _setPage(index);
      }
    });
    setState(() {
      for (int i = 0; i < offsetList.length; i++) {
        if (offsetList.indexOf(offsetList[i]) != index) {
          offsetList[i] = {i: 3};
        }
      }
    });
    if (item.haveChildren) {
      await Future.delayed(widget.animationDuration, () {
        setState(() {
          for (var item in showItems) {
            int i = showItems.indexOf(item);
            if (i != index) {
              showItems[i] = {i: false};
            }
          }
          itemSelected[index] = true;
        });
      });
    }
  }

  /// Called when an item has children.
  void _callBack(int index) {
    setState(() {
      showChildren[index] = true;
    });
    Future.delayed(Duration.zero, () {
      setState(() {
        _slideOffset = 0;
      });
    });
  }

  /// Called when an item is tapped to reverse.
  Future<void> _onReverseTap(TabItem item, int index) async {
    if (item.haveChildren) {
      setState(() {
        _slideOffset = -1.1;
      });
      Future.delayed(
          Duration(milliseconds: widget.animationDuration.inMilliseconds + 50),
          () {
        setState(() {
          showChildren[index] = false;
        });
      });
      Future.delayed(
          Duration(milliseconds: widget.animationDuration.inMilliseconds * 4),
          () {
        setState(() {
          itemSelected[index] = false;
          for (var item in showItems) {
            int i = showItems.indexOf(item);
            showItems[i] = {i: true};
          }
        });
      });
      Future.delayed(
          Duration(
              milliseconds: (widget.animationDuration.inMilliseconds * 4) + 50),
          () {
        setState(() {
          for (int i = 0; i < offsetList.length; i++) {
            offsetList[i] = {i: 0};
          }
        });
      });
    } //
    else {
      setState(() {
        for (int i = 0; i < offsetList.length; i++) {
          offsetList[i] = {i: 0};
        }
      });
    }
  }

  void _closeItems() async {
    for (int i = 0; i < itemSelected.length; i++) {
      if (onItemsTapped[i]) {
        setState(() {
          onItemsTapped[i] = !onItemsTapped[i];
          rightPadding = widget.horizontalPadding;
          leftPadding = widget.horizontalPadding;
        });
        await _onReverseTap(widget.items[i], i);
        if (widget.items[i].haveChildren) {
          Future.delayed(widget.animationDuration * 2, () {
            setState(() {
              showItemsSpace[i] = false;
            });
          });
        }
        break; // Assume only one is selected
      }
    }
  }
}
