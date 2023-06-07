import Foundation
import UIKit
import AdSupport

struct NotificationApiDeviceInfo: Codable {

    let app_id: String?
    let ad_id: String?
    let device_id: String?
    let platform: String
    let manufactuer: String
    let model: String

    init() {
        self.app_id = Bundle.main.bundleIdentifier
        self.ad_id = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        self.device_id = UIDevice.current.identifierForVendor?.uuidString
        self.platform = UIDevice.current.systemName
        self.manufactuer = "apple"
        self.model = UIDevice.current.model
    }
}
