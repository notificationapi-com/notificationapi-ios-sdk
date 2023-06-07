import Foundation

class NotificationApiRest {
    let baseUrl: String
    let credentials: NotificationApiCredentials
    let deviceInfo: NotificationApiDeviceInfo
    let session = URLSession.shared

    var authToken: String {
        get {
            return "\(credentials.clientId):\(credentials.userId):\(credentials.hashedUserId ?? "undefined")".toBase64()
        }
    }

    init(baseUrl: String, credentials: NotificationApiCredentials, deviceInfo: NotificationApiDeviceInfo) {
        self.baseUrl = baseUrl
        self.credentials = credentials
        self.deviceInfo = deviceInfo
    }

    func syncApn(token: String) async throws {
        var urlComp = URLComponents(string: baseUrl)
        urlComp?.path = "/\(credentials.clientId)/users/\(credentials.userId)/"

        if let hash = credentials.hashedUserId {
            urlComp?.queryItems = [URLQueryItem(name: "hashedUserId", value: hash)]
        }

        guard let url = urlComp?.url else {
            throw NotificationApiHttpError.invalidUrl
        }

        let body = SyncApnTokenRequestBody(pushTokens: [PushToken(type: .apn, token: token, device: deviceInfo)])

        guard let reqBody = try? JSONEncoder().encode(body) else {
            throw NotificationApiHttpError.failedToSerializeRequestBody
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("BASIC \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = reqBody

        guard let (_, res) = try? await URLSession.shared.data(for: request) else {
            throw NotificationApiHttpError.failedToSendRequest
        }

        guard let response = res as? HTTPURLResponse else {
            return
        }

        guard (200..<300).contains(response.statusCode) else {
            throw NotificationApiHttpError.badResponseStatus(response.statusCode)
        }
    }

    func trackNotification(id: String, status: String) async throws {
        // TODO: Implement
    }
}

private struct SyncApnTokenRequestBody: Codable {
    let pushTokens: [PushToken]

    init(pushTokens: [PushToken]) {
        self.pushTokens = pushTokens
    }
}

private struct PushToken: Codable {
    let type: TokenType
    let token: String
    let device: NotificationApiDeviceInfo

    init(type: TokenType, token: String, device: NotificationApiDeviceInfo) {
        self.type = .apn
        self.token = token
        self.device = device
    }
}
