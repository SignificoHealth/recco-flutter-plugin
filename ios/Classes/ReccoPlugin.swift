import Flutter
import UIKit
import ReccoUI

public class ReccoPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "recco", binaryMessenger: registrar.messenger())
        let instance = ReccoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        
        case "login":
            if let args = call.arguments as? Dictionary<String, Any>,
               let userId = args["userId"] as? String {
                Task {
                    do {
                        try await ReccoUI.login(userId: userId)
                        result(nil)
                    } catch {
                        result(
                            FlutterError(code: "loginError",
                                         message: "\(error.localizedDescription)",
                                         details: "Error during login")
                        )
                    }
                }
            }
            
        case "logout":
            Task {
                do {
                    try await ReccoUI.logout()
                    result(nil)
                } catch {
                    result(
                        FlutterError(code: "logoutError",
                                     message: "\(error.localizedDescription)",
                                     details: "Error during logout")
                    )
                }
            }
            
            
        case "openReccoUI":
            let reccoViewController = ReccoUI.reccoRootViewController()
            let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
            viewController.present(reccoViewController, animated: true)
            
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
