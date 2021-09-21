import Cocoa
import FlutterMacOS
import window_manager

class MainFlutterWindow: NSWindow {
    private var _configured: Bool = false
    
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        super.awakeFromNib()
    }
    
    override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
        super.order(place, relativeTo: otherWin)
        if (!_configured) {
            // [WindowManager] Custom your window
            let option = CustomWindowConfigureOption(
                isFrameless: false,
                visibleAtLaunch: false
            );
            customWindowConfigure(self, option)
            _configured = true
        }
    }
}
