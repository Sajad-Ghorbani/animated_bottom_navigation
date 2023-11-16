import 'package:animated_bottom_navigation/animated_bottom_navigation.dart';
import 'package:flutter/material.dart';

/// Tab item used for [AnimatedBottomNavigation].
class TabItem {
  /// Widget for icon.
  final Widget icon;

  /// Have children or not, default is false
  final bool haveChildren;

  /// Optional children list and must 2 <= children.length <= 5
  final List<TabChildrenItem>? children;

  final Color activeColor;

  final Color inActiveColor;

  /// Create item
  TabItem({
    required this.icon,
    this.haveChildren = false,
    this.children,
    this.activeColor = Colors.white,
    this.inActiveColor = Colors.black,
  }) : assert(
            children == null || (children.isNotEmpty && children.length <= 5));
}
