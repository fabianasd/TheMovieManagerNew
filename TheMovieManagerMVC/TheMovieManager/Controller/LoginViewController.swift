import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //IBActions para os botoes, no momento isso segue para o resto do aplicativo, mas o usuario nao esta realmente conectado
    @IBAction func loginTapped(_ sender: UIButton) {
        //  performSegue(withIdentifier: "completeLogin", sender: nil)
        setLoggingIn(true)
        
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success: error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        setLoggingIn(true)
        TMDBClient.getRequestToken{ (success, error) in
            if success {
                UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:],
                                          completionHandler: nil)
            }
        }
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            print(TMDBClient.Auth.requestToken)
            TMDBClient.login(username: self.emailTextField.text ?? "",
                             password: self.passwordTextField.text ?? "",
                             completion: self.handleLoginResponse(success:error:))
        } else {//valida token
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if success {
            TMDBClient.createSessionId(completion: handleSessionResponse(success:error:))
        } else {//valida email e senha
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    
    func handleSessionResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else { //valida email e senha
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn //o botão fica desabilitado
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginViaWebsiteButton.isEnabled = !loggingIn
    }
    
    func showLoginFailure(message: String) { //valida tentativa de login falha
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
