
import 'macos_webview_kit_platform_interface.dart';

class MacosWebviewKit {
  Future<String?> getPlatformVersion() {
    return MacosWebviewKitPlatform.instance.getPlatformVersion();
  }

  /*
  *  打开一个webView，内部会做缓存判断，如果之前存在（未移除），则不会新建，使用旧的。同时，对于同一个urlString，不会重新加载。
  *  urlString： 网页地址
  * */
  Future<void> openWebView({required String urlString}) {
    return MacosWebviewKitPlatform.instance.openWebView(urlString: urlString);
  }

  /*
  *  关闭webView，彻底从Window窗体进行移除。
  * */
  Future<void> closeWebView() {
    return MacosWebviewKitPlatform.instance.closeWebView();
  }

  /*
  *  显示webView，就是透明度调整为1.0。
  *  使用场景：在当前webView之上关闭弹出的弹框，让webView底图完全可见。
  * */
  Future<void> showWebView() {
    return MacosWebviewKitPlatform.instance.showWebView();
  }

  /*
  *  隐藏webView，就是透明度调整为0.1。
  *  使用场景：在当前webView之上弹出一个弹框，其webView底图仍然保持较弱的可见性。
  * */
  Future<void> hideWebView() {
    return MacosWebviewKitPlatform.instance.hideWebView();
  }
}
