//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation
import UIKit

open class NotificationApi: NSObject {
    internal static let baseUrl = "https://notificationapi.com"
    internal static let deviceInfo = NotificationApiDeviceInfo()
    internal static let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
    
    internal var credentials: NotificationApiCredentials?
    
    public static let shared = NotificationApi()
    
    private override init() {
        super.init()
        print("napi init")
    }
    
    public func configure(withCredentials credentials: NotificationApiCredentials) {
        self.credentials = credentials
    }
    
    public func requestAuthorization(completionHandler handler: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions, completionHandler: handler)
    }
    
    public func requestAuthorization() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions)
    }
    
    public func uploadApnsToken(_ token: String) async throws {
        guard credentials != nil else {
            throw NotificationApiError.missingCredentials("No credentials found. Did you forget to call NotificationApi.shared.configure()?")
        }
        
        let url = "\(NotificationApi.baseUrl)/test"
    
        guard let url = URL(string: url) else {
            throw NotificationApiError.invalidUrl(url)
        }
        
        guard let reqBody = try? JSONEncoder().encode(NotificationApi.deviceInfo) else {
            throw NotificationApiError.failedToSerializeDeviceInfo
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = reqBody
        
        guard let (data, res) = try? await URLSession.shared.data(for: request) else {
            throw NotificationApiError.failedToUploadApnsToken
        }
    }
}
