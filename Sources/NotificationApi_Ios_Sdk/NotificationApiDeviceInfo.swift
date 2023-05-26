//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation
import UIKit

internal struct NotificationApiDeviceInfo: Codable {

    let appId: String?
    let deviceId: String?
    let model: String
    let platform: String
    let platformVersion: String
    let manufactuer: String
    
    internal init() {
        self.appId = Bundle.main.bundleIdentifier
        self.deviceId = UIDevice.current.identifierForVendor?.uuidString
        self.model = UIDevice.current.model
        self.platform = UIDevice.current.systemName
        self.platformVersion = UIDevice.current.systemVersion
        self.manufactuer = "apple"
    }
}
