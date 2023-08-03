import Foundation

@objc public class NotificationApiCredentials: NSObject {

    public let clientId: String
    public let userId: String
    public let hashedUserId: String?

    @objc public init(clientId: String, userId: String, hashedUserId: String? = nil) {
        self.clientId = clientId
        self.userId = userId
        self.hashedUserId = hashedUserId
    }
}
