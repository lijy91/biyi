//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <audio_player/audio_player_plugin.h>
#include <hotkey_manager/hotkey_manager_plugin.h>
#include <libwinmedia/libwinmedia_plugin.h>
#include <screen_text_extractor/screen_text_extractor_plugin.h>
#include <tray_manager/tray_manager_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>
#include <window_manager/window_manager_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AudioPlayerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AudioPlayerPlugin"));
  HotkeyManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("HotkeyManagerPlugin"));
  LibwinmediaPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LibwinmediaPlugin"));
  ScreenTextExtractorPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenTextExtractorPlugin"));
  TrayManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("TrayManagerPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
  WindowManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowManagerPlugin"));
}
