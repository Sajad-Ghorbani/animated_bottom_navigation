import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedItem extends StatefulWidget {
  const AnimatedItem({
    Key? key,
    required this.iconOffset,
    required this.iconSelected,
    required this.onTap,
    required this.icon,
    required this.onReverseTap,
    required this.direction,
    this.callback,
    required this.index,
    required this.width,
    required this.curve,
    required this.duration,
    required this.activeColor,
    required this.inActiveColor,
    required this.spaceWidth,
    this.childrenCount,
    this.showSpaceAfterIcon = true,
    this.isFirstChild = false,
    this.haveChildren = false,
  }) : super(key: key);
  final Offset iconOffset;
  final bool iconSelected;
  final VoidCallback onTap;
  final VoidCallback onReverseTap;
  final VoidCallback? callback;
  final Widget icon;
  final bool isFirstChild;
  final bool showSpaceAfterIcon;
  final bool haveChildren;
  final double spaceWidth;
  final int index;
  final double width;
  final TextDirection direction;
  final Curve curve;
  final Duration duration;
  final Color activeColor;
  final Color inActiveColor;
  final int? childrenCount;

  @override
  State<AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem>
    with TickerProviderStateMixin {
  late Animation<double> distanceFromBeginning;
  late Animation<double> angle;
  late AnimationController animationController;
  bool isTapped = false;
  bool showSpace = false;

  @override
  void initState() {
    super.initState();
    double spaceAmount =
        widget.spaceWidth * widget.index + (widget.width * widget.index);
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration * 2,
    );
    distanceFromBeginning = Tween<double>(
      begin: spaceAmount,
      end: 0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        widget.haveChildren ? 0.4 : 0.8,
        curve: widget.curve,
      ),
    ));
    if (widget.haveChildren) {
      angle = Tween<double>(
        begin: 0,
        end: widget.direction == TextDirection.rtl ? -pi / 2 : pi / 2,
      ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.6,
          0.9,
          curve: widget.curve,
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: widget.iconOffset,
      duration: widget.duration,
      curve: widget.curve,
      child: Row(
        children: [
          if (!widget.isFirstChild)
            Visibility(
              visible: widget.iconSelected,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return SizedBox(
                    width: distanceFromBeginning.value,
                  );
                },
              ),
            ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return GestureDetector(
                onTap: () async {
                  setState(() {
                    isTapped = !isTapped;
                  });
                  if (isTapped) {
                    widget.onTap();
                    if (widget.haveChildren) {
                      Future.delayed(widget.duration, () async {
                        await animationController.forward();
                        widget.callback!();
                      });
                      Future.delayed(
                          widget.duration * 2,
                          () {
                        setState(() {
                          showSpace = true;
                        });
                      });
                    }
                  } //
                  else {
                    widget.onReverseTap();
                    if (widget.haveChildren) {
                      Future.delayed(
                          widget.duration + Duration(milliseconds: 50), () {
                        animationController.reverse();
                      });
                      Future.delayed(
                          widget.duration * 2,
                          () {
                        setState(() {
                          showSpace = false;
                        });
                      });
                    }
                  }
                },
                child: Transform.rotate(
                  angle: widget.haveChildren ? angle.value : 0,
                  child: IconTheme(
                    data: IconThemeData(
                      size: isTapped ? widget.width + 7 : widget.width,
                      color:
                          isTapped ? widget.activeColor : widget.inActiveColor,
                    ),
                    child: widget.icon,
                  ),
                ),
              );
            },
          ),
          if (widget.showSpaceAfterIcon && !showSpace)
            SizedBox(
                width: isTapped ? widget.spaceWidth - 7 : widget.spaceWidth),
          if (showSpace)
            SizedBox(
                width: widget.childrenCount != null && widget.childrenCount! > 3
                    ? 13
                    : 33),
        ],
      ),
    );
  }
}