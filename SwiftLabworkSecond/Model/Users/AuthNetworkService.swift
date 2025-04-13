import Foundation

class AuthNetworkService  : AuthNetworkServiceProtocol {
    private let baseURL = "https://alfa-itmo.ru/server/v1/storage/user-settings"
    let authString = "\(Secrets.login):\(Secrets.password)"

    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let authString = "\(Secrets.login):\(Secrets.password)"
        guard let authData = authString.data(using: .utf8) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Something go wrong"])))
            return
        }
        let authValue = "Basic \(authData.base64EncodedString())"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty data"])))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
