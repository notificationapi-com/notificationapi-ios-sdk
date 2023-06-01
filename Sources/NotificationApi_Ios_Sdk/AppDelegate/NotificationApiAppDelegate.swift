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
                let token = deviceToken.toString()
                
                notificationApi(apnTokenDidChange: token)
                
                try await NotificationApi.shared.syncApn(token: token)
            } catch {
                print("NotificationApi error. \(error)")
            }
        }
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("NotificationAPI error. Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        Task {
            do {
                let info = response.notification.request.content.userInfo
                
                notificationApi(didClickOnBackgroundNotification: info)
                
                try await NotificationApi.shared.backgroundNotificationClicked(response.notification.request.identifier)
            } catch {
                print("NotificationApi error. \(error)")
            }
        }
    }
    
    // MARK: - Callback Functions
    
    open func notificationApi(apnTokenDidChange token: String) { }
    
    open func notificationApi(didClickOnBackgroundNotification info: [AnyHashable: Any]) { }
}
