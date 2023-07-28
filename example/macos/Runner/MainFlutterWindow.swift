import Cocoa
import FlutterMacOS

class BlurryContainerViewController: NSViewController {
  let flutterViewController = FlutterViewController()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    let blurView = NSVisualEffectView()
    blurView.autoresizingMask = [.width, .height]
    blurView.blendingMode = .behindWindow
    blurView.state = .active
    if #available(macOS 10.14, *) {
        blurView.material = .sidebar
    }
    self.view = blurView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupFlutterViewController()
    NotificationCenter.default.addObserver(self, selector: #selector(openWebView(_:)), name: NSNotification.Name("openWebViewNotification"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(closeWebView), name: NSNotification.Name("closeWebViewNotification"), object: nil)
  }

  func setupFlutterViewController() {
      self.addChild(flutterViewController)
      flutterViewController.view.frame = self.view.bounds
      flutterViewController.backgroundColor = .clear
      flutterViewController.view.autoresizingMask = [.width, .height]
      self.view.addSubview(flutterViewController.view)
  }

  @objc func openWebView(_ notification: NSNotification) {
    if let mainWindow = NSApp.mainWindow as? MainFlutterWindow{

        /// receive notification
        if let urlString = notification.object as? String {
           var childVc: CustomWebViewController?

           /// read cache
           if let customWebViewVc = mainWindow.myCustomWebViewController {
              childVc = customWebViewVc
           } else {
              /// new by url
              childVc = CustomWebViewController(urlString: urlString)
              mainWindow.myCustomWebViewController = childVc!
           }
            
           /// if exist, return
            for childViewController in self.children {
                if(childViewController is CustomWebViewController) {
                    return;
                }
            }

           /// add && layout && show
           self.addChild(childVc!)
           self.view.addSubview(childVc!.view)
           childVc!.view.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               childVc!.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
               childVc!.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
               childVc!.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
               childVc!.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -150),
           ])

           /// if reset url, auto reload
           if(childVc!.urlString != urlString) {
               childVc!.webView?.evaluateJavaScript("document.body.remove()")
               childVc!.restUrlStringAndReload(resetUrlString: urlString)
           }
        }
    }
  }

  @objc func closeWebView() {
    if let mainWindow = NSApp.mainWindow as? MainFlutterWindow {
        if let webViewVcController = mainWindow.myCustomWebViewController {
            webViewVcController.view.removeFromSuperview()
            webViewVcController.removeFromParent();
        }
    }
  }
}

class MainFlutterWindow: NSWindow ,NSWindowDelegate{
  var myCustomWebViewController: CustomWebViewController?

  override func awakeFromNib() {
    delegate = self

    let blurryContainerViewController = BlurryContainerViewController()
    let windowFrame = self.frame
    self.contentViewController = blurryContainerViewController

    self.setFrame(windowFrame, display: true)

    if #available(macOS 10.13, *) {
          let customToolbar = NSToolbar()
          customToolbar.showsBaselineSeparator = false
          self.toolbar = customToolbar
        }
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        if #available(macOS 11.0, *) {
          // Use .expanded if the app will have a title bar, else use .unified
          self.toolbarStyle = .unified
        }

        self.isMovableByWindowBackground = true
        self.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)

        self.isOpaque = false
        self.backgroundColor = .clear

        RegisterGeneratedPlugins(registry: blurryContainerViewController.flutterViewController)
    super.awakeFromNib()
  }

   func window(_ window: NSWindow, willUseFullScreenPresentationOptions proposedOptions: NSApplication.PresentationOptions = []) -> NSApplication.PresentationOptions {
      // Hides the toolbar when in fullscreen mode
      return [.autoHideToolbar, .autoHideMenuBar, .fullScreen]
    }
    func windowWillEnterFullScreen(_ notification: Notification) {
          self.toolbar?.isVisible = false
      }

      func windowDidExitFullScreen(_ notification: Notification) {
          self.toolbar?.isVisible = true
      }
}
