import 'package:flutter/material.dart';
import 'package:w_flutter_tree/w_flutter_tree.dart';

import 'package:w_flutter_tree_example/custom_tree_node.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tree Example'),
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: TreeWidget<TreeModel>(
                style: CustomTreeNodeStyle(
                  direction: Axis.vertical,
                ),
                node: TreeModel(
                  name: '根节点',
                  trees: [
                    TreeModel(name: '节点1', trees: [
                      TreeModel(
                        name: '节点1-1',
                        trees: [
                          TreeModel(name: '节点1-1-1'),
                        ],
                      ),
                      TreeModel(name: '节点1-2'),
                      TreeModel(name: '节点1-3'),
                    ]),
                    TreeModel(
                      name: '节点2',
                      trees: [
                        TreeModel(name: '节点2-1'),
                        TreeModel(name: '节点2-2'),
                        TreeModel(name: '节点2-3'),
                      ],
                    ),
                  ],
                ),
                builder: (node) {
                  return CustomTreeNodeWidget(data: node);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
