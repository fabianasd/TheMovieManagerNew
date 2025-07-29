import Foundation

struct RequestTokenResponse: Codable {
    
    let success: Bool
    let expiresAt: String?
    let requestToken: String?

//havia muitas propriedades, bem como uma enumeracao de chaves de codificacao para cada uma
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
