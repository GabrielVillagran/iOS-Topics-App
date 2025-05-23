import Foundation

protocol LogInViewProtocol: AnyObject {
    func showError(message: String)
    func navigateToHome()
}

class LogInPresenter {
    
    weak var view: LogInViewProtocol?
    private let userService: UserServiceProtocol
    
    init(view: LogInViewProtocol, userService: UserServiceProtocol) {
        self.view = view
        self.userService = userService
    }
    
    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            view?.showError(message: "Please enter email and password")
            return
        }
        
        userService.login(email: email, password: password) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.view?.navigateToHome()
                } else {
                    self?.view?.showError(message: "Invalid credentials")
                }
            }
        }
    }
}
