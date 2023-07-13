# macos_webview_kit

## [0.0.1]

# 介绍：
* 兼容MacOS系统的WebView插件，可以像在iOS系统上使用WKWebView一样丝滑。在Flutter MacOS项目中，通过chanel通道，实现WebView的打开（传递url）和关闭。


# 实现原理：
1. 在Runner工程中，自定义一个CustomWebViewController.swift，继承自NSViewController，然后内部封装好WKWebView。

2. 同样地，将自动生成的FlutterViewController用一个定义的NSViewController包装起来，例如BlurryContainerViewController。

3. 更改MainFlutterWindow的contentViewController为包装了FlutterViewController的BlurryContainerViewController。

4. 在BlurryContainerViewController的viewDidLoad中添加通知监听，接收通过chanel通道Flutter发来的消息，实现webView的打开和关闭。

5. 核心方法
* NSViewController：addChild 和 removeFromParent
* NSView：addSubview 和 removeFromSuperview


# 配置DebugProfile.entitlements
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

# 引用
```
import 'package:macos_webview_kit/macos_webview_kit.dart';
```

# 使用
- 打开WebView
```
MacosWebviewKit().openWebView(urlString: "https://www.sohu.com");
```
- 关闭WebView
```
MacosWebviewKit().closeWebView();
```

# 效果
https://github.com/xiayuanquan/macos_webview_kit/assets/17963973/d1935d55-0752-429b-979a-183e234fd734
