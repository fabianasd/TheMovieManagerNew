import Foundation
import Combine

class LoginViewModel: ObservableObject { // ObservableObject para gerenciar o estado da tela
    @Published var email: String = ""
    @Published var password: String = ""

    func login() {
        // lógica real de login
        print("Login: \(email), \(password)")
    }

    func loginViaWebsite() {
        // lógica para login via site
        print("Login via website")
    }
}
