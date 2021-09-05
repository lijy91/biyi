//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audioplayers
import dart_vlc
import hotkey_manager
import package_info_plus_macos
import path_provider_macos
import screen_text_extractor
import shared_preferences_macos
import tray_manager
import uni_links_macos
import url_launcher_macos
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioplayersPlugin.register(with: registry.registrar(forPlugin: "AudioplayersPlugin"))
  DartVlcPlugin.register(with: registry.registrar(forPlugin: "DartVlcPlugin"))
  HotkeyManagerPlugin.register(with: registry.registrar(forPlugin: "HotkeyManagerPlugin"))
  FLTPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  ScreenTextExtractorPlugin.register(with: registry.registrar(forPlugin: "ScreenTextExtractorPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  TrayManagerPlugin.register(with: registry.registrar(forPlugin: "TrayManagerPlugin"))
  UniLinksMacosPlugin.register(with: registry.registrar(forPlugin: "UniLinksMacosPlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
