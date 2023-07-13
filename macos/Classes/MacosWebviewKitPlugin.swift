import Cocoa
import AppKit
import FlutterMacOS

/// Native将结果返回给Flutter。 Native =》 Flutter
public class MacosWebviewKitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "macos_webview_kit", binaryMessenger: registrar.messenger)
    let instance = MacosWebviewKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "openWebView":
       let arguments = call.arguments as? String
       NotificationCenter.default.post(name: NSNotification.Name("openWebViewNotification"), object: arguments);
       print("open ----");
       result("open webView")
   case "closeWebView":
      NotificationCenter.default.post(name: NSNotification.Name("closeWebViewNotification"), object: nil);
      print("close ----");
      result("close webView")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
