import Flutter
import UIKit

public class SwiftFlutterLocalizedCountryNamePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: Constants.CHANNEL_NAME, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterLocalizedCountryNamePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    private func getLocalizedCountryName(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError.init(code: "Invalid arguments", message: "Expected to find a dictionary with the corresponding arguments", details: nil))
            return
        }
        
        // Check countryCode was sent
        guard let countryCode = arguments[Constants.METHOD_ARG_COUNTRY_CODE] as? String else {
            result(FlutterError.init(code: "Missing argument", message: "Expected to find a value under \(Constants.METHOD_ARG_COUNTRY_CODE) key", details: nil))
            return
        }
        
        let forcedLocale = arguments[Constants.METHOD_ARG_LOCALE] as! String?
        
        var locale: Locale
        if (forcedLocale != nil) {
            locale = Locale(identifier: forcedLocale!)
        } else {
            locale = Locale.current
        }
        
        if let name = (locale as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            // Country name was found
            result(name)
        } else {
            // Country name cannot be found
            result(countryCode)
        }
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == Constants.METHOD_NAME) {
        getLocalizedCountryName(call, result: result)
    } else {
        result("Flutter method not implemented on iOS")
    }
  }
}
