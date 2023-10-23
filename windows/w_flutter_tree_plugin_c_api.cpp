#include "include/w_flutter_tree/w_flutter_tree_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "w_flutter_tree_plugin.h"

void WFlutterTreePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  w_flutter_tree::WFlutterTreePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
