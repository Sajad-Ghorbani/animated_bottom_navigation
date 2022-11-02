import 'dart:async';

import 'package:animated_bottom_navigation/src/animated_item.dart';
import 'package:animated_bottom_navigation/src/item.dart';
import 'package:animated_bottom_navigation/src/item_children.dart';
import 'package:flutter/material.dart';

typedef LetIndexPage = bool Function(int value);

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
    this.direction = TextDirection.ltr,
    this.animationCurve = Curves.easeIn,
    this.height = 75.0,
    this.cornerRadius = 20.0,
    this.horizontalPadding = 20.0,
    this.animationDuration = const Duration(milliseconds: 200),
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  final BuildContext context;
  final List<TabItem> items;
  final LetIndexPage letIndexChange;
  final ValueChanged<int>? onChanged;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final TextDirection direction;
  final Curve animationCurve;
  final double height;
  final Duration animationDuration;
  final double cornerRadius;
  final double horizontalPadding;

  /// Width of items and children
  final double width;

  @override
  State<AnimatedBottomNavigation> createState() =>
      _AnimatedBottomNavigationState();
}

class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation> {
  late double _slideOffset;
  late int _length;
  late double _constWidth;
  List<Map<int, double>> offsetList = [];
  List<Map<int, bool>> showItems = [];
  List<bool> showChildren = [];
  List<bool> itemSelected = [];
  late double rightPadding;
  late double leftPadding;

  @override
  void initState() {
    super.initState();
    rightPadding = widget.horizontalPadding;
    leftPadding = widget.horizontalPadding;
    for (int i = 0; i < widget.items.length; i++) {
      offsetList.add({i: 0});
      showItems.add({i: true});
      showChildren.add(false);
      itemSelected.add(false);
    }
    _length = widget.items.length;
    _constWidth = (MediaQuery.of(widget.context).size.width -
            (widget.horizontalPadding * 2) -
            (widget.width * _length)) /
        (_length - 1);
    _slideOffset = widget.direction == TextDirection.rtl ? -1.1 : 1.1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(widget.cornerRadius)),
          color: widget.backgroundColor,
          gradient: widget.backgroundGradient,
        ),
        padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
        height: widget.height,
        child: Directionality(
          textDirection: widget.direction,
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
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
                direction: widget.direction,
                index: index,
                isFirstChild: index == 0,
                curve: widget.animationCurve,
                showSpaceAfterIcon:
                    index != widget.items.indexOf(widget.items.last),
                duration: widget.animationDuration,
                activeColor: item.activeColor,
                inActiveColor: item.inActiveColor,
                onTap: () {
                  setState(() {
                    if (index == widget.items.indexOf(widget.items.last)) {
                      if (widget.direction == TextDirection.rtl) {
                        rightPadding = widget.horizontalPadding - 7;
                      } //
                      else {
                        leftPadding = widget.horizontalPadding - 7;
                      }
                    }
                  });
                  onTap(item, index);
                },
                callback: () {
                  callBack(index);
                },
                onReverseTap: () {
                  onReverseTap(item, index);
                },
              ),
            if (showChildren[index] == true)
              ItemChildren(
                offset: Offset(_slideOffset, 0),
                width: widget.width,
                context: context,
                curve: widget.animationCurve,
                padding: widget.horizontalPadding,
                duration: widget.animationDuration,
                children: item.children!,
              ),
          ],
        );
      }).toList(),
    );
  }

  void setPage(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(index);
    }
  }

  void onTap(TabItem item, int index) async {
    Future.delayed(
        Duration(milliseconds: widget.animationDuration.inMilliseconds * 2),
        () {
      if (widget.onChanged != null) {
        setPage(index);
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

  void callBack(int index) {
    setState(() {
      showChildren[index] = true;
    });
    Future.delayed(Duration.zero, () {
      setState(() {
        _slideOffset = 0;
      });
    });
  }

  void onReverseTap(TabItem item, int index) {
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
}
