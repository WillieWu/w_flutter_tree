import 'package:flutter/material.dart';
import 'package:w_flutter_tree/tree/custom_tree_widget.dart';

class CustomTreeNodeStyle {
  CustomTreeNodeStyle({
    this.direction = Axis.horizontal,
    this.mainAxisLeadingWidth = 30,
    this.mainAxisTrailingWidth = 30,
    this.crossAxisSpace = 20,
    this.strokeColor = const Color(0xFFB9B9B9),
    this.strokeWidth = 1,
  });

  /// 树形图方向
  final Axis direction;

  /// 树形图间隙相关
  final double mainAxisLeadingWidth;
  final double mainAxisTrailingWidth;
  final double crossAxisSpace;

  /// 树形图线的配置
  final double strokeWidth;
  final Color strokeColor;

  bool shouldRepaint(CustomTreeNodeStyle oldStyle) {
    if (mainAxisLeadingWidth != oldStyle.mainAxisLeadingWidth ||
        mainAxisTrailingWidth != oldStyle.mainAxisTrailingWidth ||
        crossAxisSpace != oldStyle.crossAxisSpace ||
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
