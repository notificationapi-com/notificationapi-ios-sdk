//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation

public struct NotificationApiCredentials {
    
    let clientId: String
    let userId: String
    let hashedUserId: String
    
    public init(clientId: String, userId: String, hashedUserId: String) {
        self.clientId = clientId
        self.userId = userId
        self.hashedUserId = hashedUserId
    }
}
