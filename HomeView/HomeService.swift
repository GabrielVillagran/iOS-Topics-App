import  Foundation

class HomeService {
    func fetchUser(completion: @escaping ([UserModel]?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let users = try? JSONDecoder().decode([UserModel].self, from: data)
            completion(users)
        }
        task.resume()
    }
}
