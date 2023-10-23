import 'dart:ui';

import 'package:w_flutter_tree/tree/custom_tree_widget.dart';

class CustomTreeNodeStyle {
  CustomTreeNodeStyle({
    this.leadingWidth = 30,
    this.trailingWidth = 30,
    this.bottomSpace = 20,
    this.strokeColor = const Color(0xFFB9B9B9),
    this.strokeWidth = 1,
  });

  /// 盒子间距相关
  final double leadingWidth;
  final double trailingWidth;
  final double bottomSpace;

  /// 树形图线的配置
  final double strokeWidth;
  final Color strokeColor;

  bool shouldRepaint(CustomTreeNodeStyle oldStyle) {
    if (leadingWidth != oldStyle.leadingWidth ||
        trailingWidth != oldStyle.trailingWidth ||
        bottomSpace != oldStyle.bottomSpace ||
        strokeWidth != oldStyle.strokeWidth ||
        strokeColor != oldStyle.strokeColor) {
      return true;
    }
    return false;
  }
}

mixin TreeNode<T> {
  T? parentNode;

  CustomMindsStrokeLineType type = CustomMindsStrokeLineType.none;

  List<T> get getChildren => throw UnimplementedError();
}
