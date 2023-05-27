//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation

public enum NotificationApiError: Error {
    case missingCredentials(String)
    case invalidUrl(String)
    case failedToSerializeDeviceInfo
    case failedToUploadApnsToken
}
