import Foundation

public enum NotificationApiError: Error {
    case missingCredentials(String)
    case notificationsUnauthorized(String)
}

public enum NotificationApiHttpError: Error {
    case invalidUrl
    case failedToSerializeRequestBody
    case failedToSendRequest
    case badResponseStatus(Int)
}
