import Foundation

@objc public class NotificationApiConfig: NSObject {

    public let baseUrl: String

    @objc public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}
