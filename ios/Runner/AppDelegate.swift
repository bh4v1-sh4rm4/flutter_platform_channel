import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller1 = window?.rootViewController as? FlutterViewController
        let methodChannel1 = FlutterMethodChannel(name: "com.bajaj.com/method_channel", binaryMessenger: controller1!.binaryMessenger)
        let eventChannel = FlutterEventChannel(name: "com.bajaj.com/event_channel", binaryMessenger: controller1!.binaryMessenger)
        methodChannel1.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if(call.method == "getResult") {
                result("Hello from iOS")
            } else if call.method == "showDialog" {
                var message = call.arguments
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: message as? String, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        DispatchQueue.main.async{
            methodChannel1.invokeMethod("iOSToFlutter", arguments: "ios se flutter me bhej raha hu value")
        }
        
        
        eventChannel.setStreamHandler(MyStreamHandler())
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
}

class MyStreamHandler: NSObject, FlutterStreamHandler {
    
    var eventSink: FlutterEventSink?
    var timer = Timer()
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            var date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let formattedDate = formatter.string(from: date)
            self.eventSink?(formattedDate)
        })
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    
}
