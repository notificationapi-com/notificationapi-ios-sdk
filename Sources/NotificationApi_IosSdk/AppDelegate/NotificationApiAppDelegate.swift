//
//  NotificationApiAppDelegate.swift
//  
//
//  Created by Devin on 2023-05-23.
//

import UIKit

@available(iOSApplicationExtension, unavailable)
open class NotificationApiAppDelegate: NSObject, UIApplicationDelegate {
    override init() {
        super.init()
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Task {
            do {
                let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

                notificationApi(apnsTokenDidChange: token)

                try await NotificationApi.shared.uploadApnsToken(token)
            } catch {
                print("NotificationApi error. \(error.localizedDescription)")
            }
        }
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("NotificationAPI error. Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    open func notificationApi(apnsTokenDidChange token: String) { }
}
