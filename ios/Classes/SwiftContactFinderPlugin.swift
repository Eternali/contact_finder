import Flutter
import UIKit
import ContactsUI

let channelName = "contact_finder"
let pickerCode = 85500

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

  func selectContact(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
    picker.dismissViewControllerAnimated(true, completion: nil)
    if contact.phoneNumbers.count > 1 {
      let multipleNumbersAlert = UIAlertController(
        title: "Which one?",
        message: "This contact has multiple phone numbers, which one do you want to use?",
        preferredStyle: UIAlertControllerStyle.Alert
      )
      for number in contact.phoneNumbers {
        if let actualNumber = number.value as? CNPhoneNumber {
          var numberLabel = number.label

          let actionTitle = numberLabel + " - " + actualNumber.stringVal
          let numberAction = UIAlertAction(
            title: actionTitle,
            style: UIAlertActionStyle.Default,
            handler: { (action) -> Void in
              var nameToSave = contact.givenName == "" ? contact.familyName == "" ? "Unknown Name" : contact.familyName : contact.givenName
              
              if let imageData = contact.imageData {
                let userImage = UIImage(data: imageData)
              }
              // use contact information
              // actualNumber.stringVal
            }
          )
          multipleNumbersAlert.addAction(numberAction)
        }
      }
      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: UIAlertActionStyle.Cancel,
        handler: { (action) -> Void in }
      )
      multipleNumbersAlert.addAction(cancelAction)
      self.presentViewController(multipleNumbersAlert, animated: true, completion: nil)
    } else {
      if contact.phoneNumbers.count > 0 {

      }
    }
  }

}
