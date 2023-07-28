import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'macos_webview_kit_platform_interface.dart';

/// Flutter调用Native的能力，Flutter =》 Native
/// An implementation of [MacosWebviewKitPlatform] that uses method channels.
class MethodChannelMacosWebviewKit extends MacosWebviewKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('macos_webview_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> openWebView({required String urlString}) async {
    if (kDebugMode) { print("open webView urlString - $urlString"); }
    final ret = await methodChannel.invokeMethod<void>('openWebView', urlString);
    return ret;
  }

  @override
  Future<void> closeWebView() async {
    if (kDebugMode) { print(""); }
    final ret = await methodChannel.invokeMethod<void>('closeWebView');
    return ret;
  }

}
