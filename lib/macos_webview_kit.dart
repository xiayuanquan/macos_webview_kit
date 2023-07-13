
import 'macos_webview_kit_platform_interface.dart';

class MacosWebviewKit {
  Future<String?> getPlatformVersion() {
    return MacosWebviewKitPlatform.instance.getPlatformVersion();
  }
  Future<void> openWebView({required String urlString}) {
    return MacosWebviewKitPlatform.instance.openWebView(urlString: urlString);
  }
  Future<void> closeWebView() {
    return MacosWebviewKitPlatform.instance.closeWebView();
  }
}
