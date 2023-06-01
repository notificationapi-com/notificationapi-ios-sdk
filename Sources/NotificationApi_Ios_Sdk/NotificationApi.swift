//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation
import UIKit

public class NotificationApi: NSObject {
    public static let shared = NotificationApi()
    
    // MARK: - Private Members

    fileprivate static let defaultConfig = NotificationApiConfig(baseUrl: "https://api.notificationapi.com")
    fileprivate static let deviceInfo = NotificationApiDeviceInfo()
    fileprivate static let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
    
    fileprivate var credentials: NotificationApiCredentials?
    fileprivate var config: NotificationApiConfig?
    fileprivate var restApi: NotificationApiRest?
        
    // MARK: - Init & Configuration
    
    private override init() {
        super.init()
    }
    
    public func configure(withCredentials credentials: NotificationApiCredentials, withConfig config: NotificationApiConfig? = nil) {
        self.credentials = credentials
        self.config = config ?? NotificationApi.defaultConfig
        self.restApi = NotificationApiRest(baseUrl: self.config!.baseUrl, credentials: self.credentials!, deviceInfo: NotificationApi.deviceInfo)
    }
    
    // MARK: - Authorization
    
    public func requestAuthorization(completionHandler handler: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions, completionHandler: handler)
    }
    
    public func requestAuthorization() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: NotificationApi.authOptions)
    }
    
    // MARK: - Tokens
    
    public func syncApn(token: String) async throws {
        guard credentials != nil else {
            throw NotificationApiError.missingCredentials("No credentials found. Did you forget to call NotificationApi.shared.configure()?")
        }
        
        guard restApi != nil else {
            return
        }
        
        try await restApi!.syncApn(token: token)
    }
    
    // MARK: - Push Notifications
    
    public func backgroundNotificationClicked(_ notificationId: String) async throws {
        guard credentials != nil else {
            throw NotificationApiError.missingCredentials("No credentials found. Did you forget to call NotificationApi.shared.configure()?")
        }
        
        guard restApi != nil else {
            return
        }
        
        try await restApi!.trackNotification(id: notificationId, status: "clicked")
    }
}
