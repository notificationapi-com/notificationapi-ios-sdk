//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation

open class NotificationApi: NSObject {
    internal static let baseUrl = "https://notificationapi.com"
    internal static let deviceInfo = NotificationApiDeviceInfo()
    
    public static let shared = NotificationApi()
    
    private override init() {
        super.init()
        print("napi init")
    }
    
    public func uploadApnsToken(_ token: String) async throws {
        print("napi token: \(token)")
        print("device info: \(NotificationApi.deviceInfo)")
    }
}
