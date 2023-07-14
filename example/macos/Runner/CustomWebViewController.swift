//
//  CustomWebViewController.swift
//  Runner
//
//  Created by 夏常聆 on 2023/7/12.
//

import Cocoa
import WebKit

class CustomWebViewController: NSViewController {
    var webView: WKWebView?

    public var urlString: String

    required init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        if let mainWindow = NSApp.mainWindow {
            view = NSView()
            view.frame = mainWindow.frame
            view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor

            webView = WKWebView()
            webView!.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1"
            webView!.translatesAutoresizingMaskIntoConstraints = false
            webView!.configuration.preferences.javaScriptEnabled = true
            webView!.navigationDelegate = self
            webView!.uiDelegate = self
            view.addSubview(webView!)

            NSLayoutConstraint.activate([
                webView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView!.topAnchor.constraint(equalTo: view.topAnchor),
                webView!.widthAnchor.constraint(equalTo: view.widthAnchor),
                webView!.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = NSApp.mainWindow {
            loadRequest()
        }
    }

    public func restUrlStringAndReload(resetUrlString: String) {
      urlString = resetUrlString
      loadRequest()
    }

    @objc func loadRequest() {
        let req = URLRequest(url: URL(string: urlString.isEmpty ? "https://www.sohu.com" : urlString)!)
        webView!.load(req)
        print("req ---- \(req)")
    }
}

extension CustomWebViewController: WKUIDelegate {
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let isMainFrame = navigationAction.targetFrame?.isMainFrame else { return nil }
        if !isMainFrame {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

extension CustomWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url?.absoluteString else { return }
        print("didStartProvisionalNavigation ----- \(url)");
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url?.absoluteString else { return }
        print("didFinish ----- \(url)");
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        guard let url = webView.url?.absoluteString else { return }
        print("\(CustomWebViewController.errorCodeToString(code: WKError.webContentProcessTerminated.rawValue)) ----- \(url)");
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        guard let url = webView.url?.absoluteString else { return }
        print("didFail ---- \(CustomWebViewController.errorCodeToString(code: error._code)) ----- \(url)");
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard let url = webView.url?.absoluteString else { return }
        print("didFailProvisionalNavigation -----  \(CustomWebViewController.errorCodeToString(code: error._code)) ----- \(url)");
    }

    static func errorCodeToString(code: Int) -> String {
        switch code {
            case WKError.unknown.rawValue:
                return "unknown";
            case WKError.webContentProcessTerminated.rawValue:
                return "webContentProcessTerminated";
            case WKError.webViewInvalidated.rawValue:
                return "webViewInvalidated";
            case WKError.javaScriptExceptionOccurred.rawValue:
                return "javaScriptExceptionOccurred";
            case WKError.javaScriptResultTypeIsUnsupported.rawValue:
                return "javaScriptResultTypeIsUnsupported";
            default:
                return "";
        }
    }
}

