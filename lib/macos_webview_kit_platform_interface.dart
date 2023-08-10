import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'macos_webview_kit_method_channel.dart';

abstract class MacosWebviewKitPlatform extends PlatformInterface {
  /// Constructs a MacosWebviewKitPlatform.
  MacosWebviewKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static MacosWebviewKitPlatform _instance = MethodChannelMacosWebviewKit();

  /// The default instance of [MacosWebviewKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelMacosWebviewKit].
  static MacosWebviewKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MacosWebviewKitPlatform] when
  /// they register themselves.
  static set instance(MacosWebviewKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openWebView({required String urlString}) {
    throw UnimplementedError('openWebView() has not been implemented.');
  }

  Future<void> closeWebView() {
    throw UnimplementedError('closeWebView() has not been implemented.');
  }

  Future<void> showWebView() {
    throw UnimplementedError('showWebView() has not been implemented.');
  }

  Future<void> hideWebView() {
    throw UnimplementedError('hideWebView() has not been implemented.');
  }
}
