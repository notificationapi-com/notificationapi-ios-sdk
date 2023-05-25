//
//  File.swift
//  
//
//  Created by Devin on 2023-05-25.
//

import Foundation

public struct NotificationApiCredentials {
    
    let apiKey: String
    let clientId: String
    let userId: String
    
    public init(apiKey: String, clientId: String, userId: String) {
        self.apiKey = apiKey
        self.clientId = clientId
        self.userId = userId
    }
}
