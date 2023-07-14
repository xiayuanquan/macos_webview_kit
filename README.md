# Flutter macos_webview_kit

## [0.0.2+2]

# 介绍（Introduce）：
* 【English】：Flutter is compatible with the WebView plug-in of the MacOS system, which can be as smooth as using WKWebView on the iOS system. In the Flutter MacOS project, the opening (passing url) and closing of WebView is realized through the chanel channel.
* 【中文】：Flutter兼容MacOS系统的WebView插件，可以像在iOS系统上使用WKWebView一样丝滑。在Flutter MacOS项目中，通过chanel通道，实现WebView的打开（传递url）和关闭。


# 实现原理（Implementation principle）：
1. * 【English】：In the Runner project, customize a CustomWebViewController.swift, inherit from NSViewController, and then encapsulate WKWebView internally.
   * 【chinese】：在Runner工程中，自定义一个CustomWebViewController.swift，继承自NSViewController，然后内部封装好WKWebView。
***

2. * 【English】：Similarly, wrap the automatically generated FlutterViewController with a defined NSViewController, such as BlurryContainerViewController.
   * 【chinese】：同样地，将自动生成的FlutterViewController用一个定义的NSViewController包装起来，例如BlurryContainerViewController。
***

3. * 【English】：Change the contentViewController of MainFlutterWindow to BlurryContainerViewController that wraps FlutterViewController.
   * 【chinese】：将MainFlutterWindow的contentViewController更改为包装FlutterViewController的BlurryContainerViewController。。
*** 

4. * 【English】：Add notification monitoring in viewDidLoad of BlurryContainerViewController to receive messages from Flutter through the chanel channel to open and close webView.
   * 【chinese】：在BlurryContainerViewController的viewDidLoad中添加通知监听，通过chanel通道接收来自Flutter的消息来打开和关闭webView。
***

5. * 【English】：core method
   * 【chinese】：核心方法
     * NSViewController：addChild && removeFromParent
     * NSView：addSubview && removeFromSuperview



# 配置DebugProfile.entitlements（configuration）：
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.security.app-sandbox</key>
	<true/>
	<key>com.apple.security.cs.allow-jit</key>
	<true/>
	<key>com.apple.security.network.server</key>
	<true/>
	<key>com.apple.security.network.client</key>
    <true/>
</dict>
</plist>
```

# 导入（import）：
```
import 'package:macos_webview_kit/macos_webview_kit.dart';
```

# 使用（useage）：
- open WebView
```
MacosWebviewKit().openWebView(urlString: "https://www.sohu.com");
```
- close WebView
```
MacosWebviewKit().closeWebView();
```

# 效果（effect）：
https://github.com/xiayuanquan/macos_webview_kit/assets/17963973/d1935d55-0752-429b-979a-183e234fd734
