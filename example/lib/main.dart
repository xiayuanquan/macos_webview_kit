import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:macos_webview_kit/macos_webview_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _macosWebviewKitPlugin = MacosWebviewKit();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _macosWebviewKitPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> openWebView1() async {
    await _macosWebviewKitPlugin.openWebView(urlString: "https://www.sohu.com");
  }

  Future<void> openWebView2() async {
    await _macosWebviewKitPlugin.openWebView(urlString: "https://www.baidu.com");
  }

  Future<void> closeWebView() async {
    await _macosWebviewKitPlugin.closeWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () => openWebView1(), child: const Text("open webView1")),
                  ElevatedButton(onPressed: () => openWebView2(), child: const Text("open webView2")),
                  ElevatedButton(onPressed: () => closeWebView(), child: const Text("close webView")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
