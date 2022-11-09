import 'package:animated_bottom_navigation/animated_bottom_navigation.dart';
import 'package:flutter/material.dart';

/// Tab children item used for [TabItem].
class TabChildrenItem {
  /// Optional title for item
  final String? title;

  /// Icon for item
  final Widget icon;

  /// Optional call back for tap on item
  final VoidCallback onTap;

  /// Color of icon and title, default is [Color.white]
  final Color color;

  const TabChildrenItem({
    this.title,
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });
}
