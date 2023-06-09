import Foundation

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension Data {
    func toString() -> String {
        return self.map { String(format: "%02.2hhx", $0) }.joined()
    }
}
