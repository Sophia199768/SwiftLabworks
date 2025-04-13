import Foundation

protocol AuthNetworkServiceProtocol {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

