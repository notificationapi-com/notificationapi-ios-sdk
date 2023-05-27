//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation

public struct NotificationApiCredentials {
    
    public let clientId: String
    public let userId: String
    public let hashedUserId: String
    
    public init(clientId: String, userId: String, hashedUserId: String) {
        self.clientId = clientId
        self.userId = userId
        self.hashedUserId = hashedUserId
    }
}
