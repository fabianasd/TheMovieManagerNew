
import Foundation

public struct TMDBClient {
    static let apiKey = ""

    public struct Auth {
        public static var accountId = 0
        public static var requestToken = ""
        public static var sessionId = ""
    }

    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"

        case getWatchlist
        case getRequestToken
        case login
        case createSessionId
        case webAuth
        case logout
        case getFavorites
        case search(String)
        case markWatchlist
        case markFavorite
        case posterImage(String)

        var stringValue: String {
            switch self {
            case .getWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getRequestToken:
                return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
            case .login:
                return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
            case .createSessionId:
                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
            case .logout:
                return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            case .getFavorites:
                return Endpoints.base + "/account/\(Auth.accountId)/favorite/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .search(let query):
                return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            case .markWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .markFavorite:
                return Endpoints.base + "/account/\(Auth.accountId)/favorite" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .posterImage(let posterPath):
                return "https://image.tmdb.org/t/p/w500/" + posterPath
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    // MARK: - Autenticação

    public static func getRequestToken() async throws -> String {
        let url = Endpoints.getRequestToken.url
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
        Auth.requestToken = response.requestToken ?? ""
        return response.requestToken ?? ""
    }

    public static func login(username: String, password: String, requestToken: String) async throws -> Bool {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LoginRequest(username: username, password: password, requestToken: requestToken)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
        Auth.requestToken = response.requestToken ?? ""
        return true
    }

    public static func createSessionId(requestToken: String) async throws -> String {
        var request = URLRequest(url: Endpoints.createSessionId.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = PostSession(requestToken: requestToken)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(SessionResponse.self, from: data)
        Auth.sessionId = response.sessionId ?? ""
        return response.sessionId ?? ""
    }

    public static func logout() async {
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = LogoutRequest(sessionId: Auth.sessionId)
        request.httpBody = try? JSONEncoder().encode(body)
        _ = try? await URLSession.shared.data(for: request)
        Auth.sessionId = ""
        Auth.requestToken = ""
    }

    // MARK: - API de Filmes

    static func search(query: String) async throws -> [Movie] {
        let url = Endpoints.search(query).url
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MovieResults.self, from: data).results
    }

    static func getWatchlist() async throws -> [Movie] {
        let url = Endpoints.getWatchlist.url
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MovieResults.self, from: data).results
    }

    static func getFavorites() async throws -> [Movie] {
        let url = Endpoints.getFavorites.url
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MovieResults.self, from: data).results
    }

    public static func markFavorite(movieId: Int, favorite: Bool) async throws -> Bool {
        let url = Endpoints.markFavorite.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = MarkFavorite(mediaType: "movie", mediaId: movieId, favorite: favorite)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(TMDBResponse.self, from: data)

        return [1, 12, 13].contains(response.statusCode)
    }

    public static func markWatchlist(movieId: Int, watchlist: Bool) async throws -> Bool {
        let url = Endpoints.markWatchlist.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = MarkWatchlist(mediaType: "movie", mediaId: movieId, watchlist: watchlist)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(TMDBResponse.self, from: data)

        return [1, 12, 13].contains(response.statusCode)
    }

    public static func downloadPosterImage(path: String) async throws -> Data? {
        let url = Endpoints.posterImage(path).url
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
