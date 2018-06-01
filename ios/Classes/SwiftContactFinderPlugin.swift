import Flutter
import UIKit

static let channelName = "contact_finder"
static let pickerCode = 85500

public class SwiftContactFinderPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
    let instance = SwiftContactFinderPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if (call.method == "selectContact") {
      result({  })
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

}
