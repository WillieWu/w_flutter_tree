import 'package:flutter/material.dart';

class TreeWidget<T extends TreeNode<T>> extends StatelessWidget {
  const TreeWidget({
    super.key,
    required this.node,
    required this.builder,
  });

  final T node;
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
          bottomSpace: subNode.bottomSpace,
        ),
        child: Row(
          children: [
            RepaintBoundary(
              child: CustomPaint(
                foregroundPainter: CustomTreePainter(
                  leadingWidth: subNode.leadingWidth,
                  trailingWidth: subNode.trailingWidth,
                  bottomSpace: subNode.bottomSpace,
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
                          padding: EdgeInsets.only(left: subNode.leadingWidth),
                          child: builder(subNode),
                        ),
                        SizedBox(
                          height: subNode.bottomSpace,
                        )
                      ],
                    ),
                    if (hasChildren)
                      SizedBox(
                        // color: Colors.red,
                        width: subNode.trailingWidth,
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
    super.bottomSpace,
    super.strokeWidth,
  });

  final CustomMindsStrokeLineType type;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    canvas.save();

    switch (type) {
      case CustomMindsStrokeLineType.up:
        canvas.drawLine(Offset.zero, Offset(0, (size.height - bottomSpace) / 2), paint);
        break;
      case CustomMindsStrokeLineType.down:
        canvas.drawLine(Offset(0, (size.height - bottomSpace) / 2), Offset(0, size.height), paint);
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
    this.strokeWidth = 1,
    this.strokeColor = const Color(0xFFB9B9B9),
    this.leadingWidth = 20,
    this.trailingWidth = 20,
    this.bottomSpace = 0,
    this.hasChildren = false,
    this.hasParent = false,
    this.circleRadius = 3,
    this.showleadingDot = false,
    this.showTrailingDot = false,
  });

  final double strokeWidth;
  final Color strokeColor;
  final double leadingWidth;
  final double trailingWidth;
  final double bottomSpace;
  final bool hasChildren;
  final bool hasParent;
  final bool showTrailingDot;
  final bool showleadingDot;

  final double circleRadius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    final childHeight = size.height - bottomSpace;
    final endPoint = Offset(leadingWidth - circleRadius - strokeWidth, childHeight / 2);

    canvas.save();

    if (hasParent) {
      canvas.drawLine(
          Offset(0, childHeight / 2), showleadingDot ? endPoint : Offset(leadingWidth, childHeight / 2), paint);
      if (showleadingDot) {
        canvas.drawCircle(Offset(leadingWidth - circleRadius - strokeWidth, childHeight / 2), 3, paint);
      }
    }

    if (hasChildren) {
      canvas.drawLine(
        Offset(size.width - trailingWidth, childHeight / 2),
        Offset(showTrailingDot ? size.width - circleRadius * 2 : size.width, childHeight / 2),
        paint,
      );
      if (showTrailingDot) {
        canvas.drawCircle(Offset(size.width - circleRadius * 2, childHeight / 2), circleRadius, paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomTreePainter oldDelegate) {
    if (hasChildren != oldDelegate.hasChildren ||
        hasParent != oldDelegate.hasParent ||
        bottomSpace != oldDelegate.bottomSpace ||
        strokeWidth != oldDelegate.strokeWidth ||
        circleRadius != oldDelegate.circleRadius) {
      return true;
    }
    return false;
  }

  @override
  bool shouldRebuildSemantics(CustomTreePainter oldDelegate) => false;
}

mixin TreeNode<T> {
  T? parentNode;

  double leadingWidth = 30;
  double trailingWidth = 30;

  CustomMindsStrokeLineType type = CustomMindsStrokeLineType.none;

  double bottomSpace = 20;
  List<T> get getChildren => throw UnimplementedError();
}
