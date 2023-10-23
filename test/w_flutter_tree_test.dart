import 'package:flutter_test/flutter_test.dart';
import 'package:w_flutter_tree/w_flutter_tree.dart';
import 'package:w_flutter_tree/w_flutter_tree_platform_interface.dart';
import 'package:w_flutter_tree/w_flutter_tree_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWFlutterTreePlatform
    with MockPlatformInterfaceMixin
    implements WFlutterTreePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WFlutterTreePlatform initialPlatform = WFlutterTreePlatform.instance;

  test('$MethodChannelWFlutterTree is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWFlutterTree>());
  });

  test('getPlatformVersion', () async {
    WFlutterTree wFlutterTreePlugin = WFlutterTree();
    MockWFlutterTreePlatform fakePlatform = MockWFlutterTreePlatform();
    WFlutterTreePlatform.instance = fakePlatform;

    expect(await wFlutterTreePlugin.getPlatformVersion(), '42');
  });
}
