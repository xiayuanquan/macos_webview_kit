# Flutter macos_webview_kit

## [0.0.3]

# Introduce 
* Flutter is compatible with the WebView plug-in of the MacOS system, which can be as smooth as using WKWebView on the iOS system. In the Flutter MacOS project, the opening (passing url) and closing of WebView is realized through the chanel channel.

# config ***.entitlements
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

# import
```
import 'package:macos_webview_kit/macos_webview_kit.dart';
```

# usage
- open 
```
MacosWebviewKit().openWebView(urlString: "https://www.sohu.com");
```

- close 
```
MacosWebviewKit().closeWebView();
```

- show 
```
MacosWebviewKit().showWebView();
```

- hide 
```
MacosWebviewKit().hideWebView();
```

# effect
https://github.com/xiayuanquan/macos_webview_kit/assets/17963973/d1935d55-0752-429b-979a-183e234fd734
