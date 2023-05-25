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
    internal var credentials: NotificationApiCredentials?
    
    public static let shared = NotificationApi()
    
    private override init() {
        super.init()
        print("napi init")
    }
    
    public func configure(withCredentials credentials: NotificationApiCredentials) {
        self.credentials = credentials
    }
    
    public func uploadApnsToken(_ token: String) async throws {
        guard credentials != nil else {
            throw NotificationApiError.missingCredentials("No credentials found. Did you forget to call NotificationApi.shared.configure()?")
        }
        
        print("napi token: \(token)")
        print("device info: \(NotificationApi.deviceInfo)")
    }
}
