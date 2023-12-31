import 'package:flutter/material.dart';
import 'package:w_flutter_tree/w_flutter_tree.dart';

class TreeModel with TreeNode<TreeModel> {
  final String name;
  final List<TreeModel>? trees;

  TreeModel({required this.name, this.trees});

  @override
  List<TreeModel> get getChildren => trees ?? [];

  @override
  String toString() {
    return 'TreeModel({name: $name, trees: $trees})';
  }
}

class CustomTreeNodeWidget extends StatelessWidget {
  const CustomTreeNodeWidget({
    required this.data,
    super.key,
  });

  final TreeModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlateNodeWidget(
          title: data.name,
          subTitle: '宽度根据内容自适应',
          subTitleColor: Colors.red,
          isSelected: false,
        ),
        // const SizedBox(
        //   width: 3,
        // ),
      ],
    );
  }
}

class PlateNodeWidget extends StatelessWidget {
  const PlateNodeWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.subTitleColor,
    this.isSelected = false,
  });

  final bool isSelected;
  final String title;
  final String subTitle;
  final Color subTitleColor;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? const Color(0xFFED3130) : const Color(0xFFE8E8E8);
    final titleColor = isSelected ? const Color(0xFFED3130) : const Color(0xFF3A3A3A);
    final backColor = isSelected ? const Color(0x0CED3130) : const Color(0xFFE5E5E5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      decoration: ShapeDecoration(
        color: backColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.25, color: borderColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: subTitleColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
