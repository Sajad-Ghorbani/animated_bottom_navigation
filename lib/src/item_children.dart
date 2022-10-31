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
  late int _length;

  @override
  void initState() {
    super.initState();
    _length = widget.children.length;
    width = (MediaQuery.of(widget.context).size.width -
            // because padding is 40 and space between first item and children is 40
            ((widget.padding * 2) + 40) -
            (widget.width * (_length + 1))) /
        (_length - 1);
    addSizedBox();
  }

  addSizedBox() {
    for (int i = 0; i < widget.children.length; i++) {
      if (widget.children[i].key == ValueKey('$i')) {
        //pass
      } //
      else {
        if (i.isOdd) {
          widget.children.insert(
            i,
            SizedBox(
              key: ValueKey('$i'),
              width: width,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: widget.offset,
      duration: widget.duration,
      curve: Curves.linearToEaseOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.children,
      ),
    );
  }
}
