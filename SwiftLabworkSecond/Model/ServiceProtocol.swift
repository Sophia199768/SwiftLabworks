import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
