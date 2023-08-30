import Flutter
import UIKit
import ReccoUI

extension UIWindow {
    fileprivate func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else if top?.children.count == 1 {
                top = top?.children.first
            } else {
                break
            }
        }
        return top
    }
}

public class ReccoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "recco", binaryMessenger: registrar.messenger())
        let instance = ReccoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {

        case "initialize":
            if let args = call.arguments as? Dictionary<String, Any>,
               let clientSecret = args["clientSecret"] as? String {

               if let style = args["style"] as? [String: Any] {
                 let styleName = style["name"] as! String
                 let colors = style["colors"] as! [String: Any]
                 let dark = colors["dark"] as! [String: String]
                 let light = colors["light"] as! [String: String]
                   
                 let reccoFont: ReccoFont

                 switch style["iosFont"] as! String {
                    case "helveticaNeue":
                        reccoFont = ReccoFont.helveticaNeue
                    case "avenirNext":
                        reccoFont = ReccoFont.avenirNext
                    case "appleSdGothicNeo":
                        reccoFont = ReccoFont.appleSdGothicNeo
                    case "georgia":
                        reccoFont = ReccoFont.georgia
                    default:
                        reccoFont = ReccoFont.sfPro
                 }
                   
                 let reccoStyle = ReccoStyle(
                    name: styleName,
                    font: reccoFont,
                    color: .init(
                    primary: .init(lightModeHex: light["primary"]!.fixJavaHex, darkModeHex: dark["primary"]!.fixJavaHex),
                    onPrimary: .init(lightModeHex: light["onPrimary"]!.fixJavaHex, darkModeHex: dark["onPrimary"]!.fixJavaHex),
                    background: .init(lightModeHex: light["background"]!.fixJavaHex, darkModeHex: dark["onPrimary"]!.fixJavaHex),
                    onBackground: .init(lightModeHex: light["onBackground"]!.fixJavaHex, darkModeHex: dark["onBackground"]!.fixJavaHex),
                    accent: .init(lightModeHex: light["accent"]!.fixJavaHex, darkModeHex: dark["accent"]!.fixJavaHex),
                    onAccent: .init(lightModeHex: light["onAccent"]!.fixJavaHex, darkModeHex: dark["onAccent"]!.fixJavaHex),
                    illustration: .init(lightModeHex: light["illustration"]!.fixJavaHex, darkModeHex: dark["illustration"]!.fixJavaHex),
                    illustrationLine: .init(lightModeHex: light["illustrationOutline"]!.fixJavaHex, darkModeHex: dark["illustrationOutline"]!.fixJavaHex)
                    )
                 )

                 ReccoUI.initialize(clientSecret: clientSecret, style: reccoStyle)
               } else {
                 ReccoUI.initialize(clientSecret: clientSecret)
               }

               result(nil)
            }

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

            UIApplication.shared
                .delegate?
                .window??
                .topViewController()?
                .present(reccoViewController, animated: true)
            
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}


extension String {
    fileprivate var fixJavaHex: String {
        let secondIndex = index(after: startIndex)
        let thirdIndex = index(after: secondIndex)

        let alphaRange = secondIndex...thirdIndex
        let alpha = self[alphaRange]
        return "#\(dropFirst(3))\(alpha)"
    }
}
