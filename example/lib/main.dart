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
              child: Container(
                color: Colors.red,
                child: TreeWidget<TreeModel>(
                  node: TreeModel(
                    name: '0',
                    trees: [
                      TreeModel(name: '1', trees: [
                        TreeModel(name: '2', trees: [TreeModel(name: '7')]),
                        TreeModel(name: '3'),
                        TreeModel(name: '4'),
                      ]),
                      TreeModel(name: '4', trees: [
                        TreeModel(name: '5'),
                        TreeModel(name: '6'),
                        TreeModel(name: '4'),
                      ]),
                    ],
                  ),
                  builder: (node) {
                    return CustomTreeNodeWidget(data: node);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
