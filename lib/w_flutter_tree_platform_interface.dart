import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'w_flutter_tree_method_channel.dart';

abstract class WFlutterTreePlatform extends PlatformInterface {
  /// Constructs a WFlutterTreePlatform.
  WFlutterTreePlatform() : super(token: _token);

  static final Object _token = Object();

  static WFlutterTreePlatform _instance = MethodChannelWFlutterTree();

  /// The default instance of [WFlutterTreePlatform] to use.
  ///
  /// Defaults to [MethodChannelWFlutterTree].
  static WFlutterTreePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WFlutterTreePlatform] when
  /// they register themselves.
  static set instance(WFlutterTreePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
