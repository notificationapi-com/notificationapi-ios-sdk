//
//  NotificationApiAppDelegate.swift
//  
//
//  Created by Devin on 2023-05-23.
//

import UIKit

@available(iOSApplicationExtension, unavailable)
open class NotificationApiAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    // MARK: - Init
    
    override init() {
        super.init()
        
        UNUserNotificationCenter.current().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    // MARK: - Delegate Functions
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Task {
            do {
                let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

                notificationApi(apnTokenDidChange: token)
                
                try await NotificationApi.shared.uploadApnsToken(token)
            } catch {
                print("NotificationApi error. \(error)")
            }
        }
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("NotificationAPI error. Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // MARK: - Callback Functions
    
    open func notificationApi(apnTokenDidChange token: String) { }
}
