import Foundation

protocol UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void)
}

class UserService: UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if email == "test@test.com" && password == "12345678" {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
