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
  }) : super(key: key);
  final Offset offset;
  final List<Widget> children;
  final double width;
  final BuildContext context;
  final Curve curve;
  final Duration duration;
  final double padding;

  @override
  State<ItemChildren> createState() => _ItemChildrenState();
}

class _ItemChildrenState extends State<ItemChildren> {
  late double width;

  @override
  void initState() {
    super.initState();
    width = MediaQuery.of(widget.context).size.width -
        ((widget.padding * 2) + 40 + widget.width);
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
          children: widget.children.map((item) {
            return IconTheme(
              data: IconThemeData(size: widget.width),
              child: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
