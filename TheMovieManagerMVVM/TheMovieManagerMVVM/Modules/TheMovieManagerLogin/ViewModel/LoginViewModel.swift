import Foundation

@MainActor
public class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false

    public init() {}
    func login() async {
        isLoading = true
        errorMessage = nil

        do {
            let token = try await TMDBClient.getRequestToken()
            let success = try await TMDBClient.login(username: username, password: password, requestToken: token)

            if success {
                let sessionId = try await TMDBClient.createSessionId(requestToken: token)
                TMDBClient.Auth.sessionId = sessionId

                let accountId = try await TMDBClient.getAccountId()
                TMDBClient.Auth.accountId = accountId

                isAuthenticated = true
            } else {
                errorMessage = "Falha ao validar credenciais."
            }
        } catch {
            errorMessage = "Erro no login: \(error.localizedDescription)"
        }

        isLoading = false
    }

}
