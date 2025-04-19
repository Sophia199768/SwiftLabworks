import Foundation

protocol UniversityNetworkServiceProtocol {
    func getUniversities(page: Int, completion: @escaping (Result<[UniversityEntry], Error>) -> Void)
    func invalidateCache()
}
