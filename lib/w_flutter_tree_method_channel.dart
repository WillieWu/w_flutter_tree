import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'w_flutter_tree_platform_interface.dart';

/// An implementation of [WFlutterTreePlatform] that uses method channels.
class MethodChannelWFlutterTree extends WFlutterTreePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('w_flutter_tree');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
