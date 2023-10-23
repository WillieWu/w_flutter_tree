import 'package:flutter/material.dart';
import 'package:w_flutter_tree/tree/custom_tree_style.dart';

class TreeWidget<T extends TreeNode<T>> extends StatelessWidget {
  const TreeWidget({
    super.key,
    required this.node,
    required this.style,
    required this.builder,
  });

  final T node;
  final CustomTreeNodeStyle style;
  final Widget Function(T node) builder;

  Widget _traverseTree(T subNode) {
    final nodes = subNode.getChildren;
    // print(subNode.toString());
    if (nodes.isEmpty) {
      return _buildTree(subNode);
    }
    final trees = <Widget>[];
    for (var i = 0; i < nodes.length; i++) {
      final element = nodes[i];
      element.parentNode = subNode;
      if (nodes.length == 1) {
        /// 仅有一个子项
        element.type = CustomMindsStrokeLineType.onlyLine;
      } else if (i == 0) {
        /// 第一个子项
        element.type = CustomMindsStrokeLineType.down;
      } else if (i == nodes.length - 1) {
        /// 最后一个子项
        element.type = CustomMindsStrokeLineType.up;
      } else {
        /// 中间子项
        element.type = CustomMindsStrokeLineType.center;
      }
      trees.add(_traverseTree(element));
    }

    return _buildTree(subNode, subTrees: trees);
  }

  Widget _buildTree(T subNode, {List<Widget> subTrees = const []}) {
    final hasChildren = subTrees.isNotEmpty;
    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: CustomLinePainter(
          type: subNode.type,
          style: style,
        ),
        child: Flex(
          direction: style.direction,
          children: [
            RepaintBoundary(
              child: CustomPaint(
                foregroundPainter: CustomTreePainter(
                  style: style,
                  hasParent: subNode.parentNode != null,
                  hasChildren: hasChildren,
                ),
                child: Flex(
                  direction: style.direction,
                  children: [
                    Flex(
                      direction: style.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: style.direction == Axis.horizontal
                              ? EdgeInsets.only(left: style.mainAxisLeadingWidth)
                              : EdgeInsets.only(top: style.mainAxisLeadingWidth),
                          child: builder(subNode),
                        ),
                        SizedBox(
                          height: style.direction == Axis.horizontal ? style.crossAxisSpace : 0,
                          width: style.direction == Axis.horizontal ? 0 : style.crossAxisSpace,
                        )
                      ],
                    ),
                    if (hasChildren)
                      SizedBox.fromSize(
                          size: style.direction == Axis.horizontal
                              ? Size(style.mainAxisTrailingWidth, 30)
                              : Size(30, style.mainAxisTrailingWidth)),
                  ],
                ),
              ),
            ),
            if (hasChildren)
              Flex(
                direction: style.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subTrees,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _traverseTree(node);
  }
}

enum CustomMindsStrokeLineType { up, down, center, onlyLine, none }

class CustomLinePainter extends CustomTreePainter {
  CustomLinePainter({
    this.type = CustomMindsStrokeLineType.none,
    required super.style,
  });

  final CustomMindsStrokeLineType type;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = style.strokeWidth
      ..color = style.strokeColor
      ..style = PaintingStyle.fill;

    canvas.save();
    switch (type) {
      case CustomMindsStrokeLineType.up:
        final p1 = style.direction == Axis.horizontal ? Offset.zero : Offset.zero;
        final p2 = style.direction == Axis.horizontal
            ? Offset(0, (size.height - style.crossAxisSpace) / 2)
            : Offset((size.width - style.crossAxisSpace) / 2, 0);
        canvas.drawLine(p1, p2, paint);
        break;
      case CustomMindsStrokeLineType.down:
        final p1 = style.direction == Axis.horizontal
            ? Offset(0, (size.height - style.crossAxisSpace) / 2)
            : Offset(size.width, 0);
        final p2 = style.direction == Axis.horizontal
            ? Offset(0, size.height)
            : Offset((size.width - style.crossAxisSpace) / 2, 0);
        canvas.drawLine(p1, p2, paint);
        break;
      case CustomMindsStrokeLineType.center:
        canvas.drawLine(
            Offset.zero, style.direction == Axis.horizontal ? Offset(0, size.height) : Offset(size.width, 0), paint);
        break;
      default:
    }

    canvas.restore();
  }
}

class CustomTreePainter extends CustomPainter {
  CustomTreePainter({
    required this.style,
    this.hasChildren = false,
    this.hasParent = false,
  });

  final CustomTreeNodeStyle style;
  final bool hasChildren;
  final bool hasParent;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = style.strokeWidth
      ..color = style.strokeColor
      ..style = PaintingStyle.fill;

    final childHeight = (style.direction == Axis.horizontal ? size.height : size.width) - style.crossAxisSpace;

    canvas.save();

    if (hasParent) {
      final p1 = style.direction == Axis.horizontal ? Offset(0, childHeight / 2) : Offset(childHeight / 2, 0);
      final p2 = style.direction == Axis.horizontal
          ? Offset(style.mainAxisLeadingWidth, childHeight / 2)
          : Offset(childHeight / 2, style.mainAxisLeadingWidth);
      canvas.drawLine(p1, p2, paint);
    }

    if (hasChildren) {
      final p1 = style.direction == Axis.horizontal
          ? Offset(size.width - style.mainAxisTrailingWidth, childHeight / 2)
          : Offset(childHeight / 2, size.height - style.mainAxisTrailingWidth);
      final p2 = style.direction == Axis.horizontal
          ? Offset(size.width, childHeight / 2)
          : Offset(childHeight / 2, size.height);
      canvas.drawLine(
        p1,
        p2,
        paint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomTreePainter oldDelegate) => style.shouldRepaint(oldDelegate.style);

  @override
  bool shouldRebuildSemantics(CustomTreePainter oldDelegate) => false;
}
