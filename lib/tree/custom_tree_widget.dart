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
    // print('$subNode :> ${subNode.type}');
    final hasChildren = subTrees.isNotEmpty;
    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: CustomLinePainter(
          type: subNode.type,
          style: style,
        ),
        child: Row(
          children: [
            RepaintBoundary(
              child: CustomPaint(
                foregroundPainter: CustomTreePainter(
                  style: style,
                  hasParent: subNode.parentNode != null,
                  hasChildren: hasChildren,
                  // showTrailingDot: hasChildren && subNode.getChildren.length > 1,
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: style.leadingWidth),
                          child: builder(subNode),
                        ),
                        SizedBox(
                          height: style.bottomSpace,
                        )
                      ],
                    ),
                    if (hasChildren)
                      SizedBox(
                        // color: Colors.red,
                        width: style.trailingWidth,
                        height: 30,
                      ),
                  ],
                ),
              ),
            ),
            if (hasChildren)
              Column(
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
        canvas.drawLine(Offset.zero, Offset(0, (size.height - style.bottomSpace) / 2), paint);
        break;
      case CustomMindsStrokeLineType.down:
        canvas.drawLine(Offset(0, (size.height - style.bottomSpace) / 2), Offset(0, size.height), paint);
        break;
      case CustomMindsStrokeLineType.center:
        canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
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

    final childHeight = size.height - style.bottomSpace;

    canvas.save();

    if (hasParent) {
      canvas.drawLine(Offset(0, childHeight / 2), Offset(style.leadingWidth, childHeight / 2), paint);
    }

    if (hasChildren) {
      canvas.drawLine(
        Offset(size.width - style.trailingWidth, childHeight / 2),
        Offset(size.width, childHeight / 2),
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
