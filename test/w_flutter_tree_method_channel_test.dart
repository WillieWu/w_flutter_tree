import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:w_flutter_tree/w_flutter_tree_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWFlutterTree platform = MethodChannelWFlutterTree();
  const MethodChannel channel = MethodChannel('w_flutter_tree');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
