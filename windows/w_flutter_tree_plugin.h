#ifndef FLUTTER_PLUGIN_W_FLUTTER_TREE_PLUGIN_H_
#define FLUTTER_PLUGIN_W_FLUTTER_TREE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace w_flutter_tree {

class WFlutterTreePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WFlutterTreePlugin();

  virtual ~WFlutterTreePlugin();

  // Disallow copy and assign.
  WFlutterTreePlugin(const WFlutterTreePlugin&) = delete;
  WFlutterTreePlugin& operator=(const WFlutterTreePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace w_flutter_tree

#endif  // FLUTTER_PLUGIN_W_FLUTTER_TREE_PLUGIN_H_
