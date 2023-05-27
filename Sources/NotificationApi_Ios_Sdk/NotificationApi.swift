//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation
import UIKit

open class NotificationApi: NSObject {
    public static let shared = NotificationApi()
    
    // MARK: - Private Members

    internal static let defaultConfig = NotificationApiConfig(baseUrl: "https://notificationapi.com")
    internal static let deviceInfo = NotificationApiDeviceInfo()
    internal static let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
    
    internal var credentials: NotificationApiCredentials?
    internal var config: NotificationApiConfig?
        
    // MARK: - Init & Configuration
    
    private override init() {
        super.init()
    }
    
    public func configure(withCredentials credentials: NotificationApiCredentials, withConfig config: NotificationApiConfig? = nil) {
        self.credentials = credentials
        self.config = config ?? NotificationApi.defaultConfig
    }
    
    // MARK: - Authorization
    
    public func requestAuthorization(completionHandler handler: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions, completionHandler: handler)
    }
    
    public func requestAuthorization() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions)
    }
    
    // MARK: - Tokens
    
    public func uploadApnsToken(_ token: String) async throws {
        guard credentials != nil else {
            throw NotificationApiError.missingCredentials("No credentials found. Did you forget to call NotificationApi.shared.configure()?")
        }
        
        let url = "\(config!.baseUrl)/test"
    
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
