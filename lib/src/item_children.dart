import 'package:animated_bottom_navigation/src/tab_children_item.dart';
import 'package:flutter/material.dart';

class ItemChildren extends StatefulWidget {
  const ItemChildren({
    Key? key,
    required this.offset,
    required this.children,
    required this.width,
    required this.context,
    required this.curve,
    required this.duration,
    required this.padding,
    required this.margin,
  }) : super(key: key);

  final Offset offset;
  final List<TabChildrenItem> children;
  final double width;
  final BuildContext context;
  final Curve curve;
  final Duration duration;
  final double padding;
  final double margin;

  @override
  State<ItemChildren> createState() => _ItemChildrenState();
}

class _ItemChildrenState extends State<ItemChildren> {
  late double width;

  @override
  void initState() {
    super.initState();
    // Calculate the width of the children
    width = MediaQuery.of(widget.context).size.width -
        ((widget.padding * 2) +
            widget.margin +
            (widget.children.length > 3 ? 20 : 40) +
            widget.width);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: widget.offset,
      duration: widget.duration,
      curve: widget.curve,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.children.map((TabChildrenItem item) {
            return IconTheme(
              data: IconThemeData(
                size: widget.width,
                color: item.color,
              ),
              child: GestureDetector(
                onTap: item.onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.icon,
                    if (item.title != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        item.title!,
                        style: TextStyle(
                          color: item.color,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
