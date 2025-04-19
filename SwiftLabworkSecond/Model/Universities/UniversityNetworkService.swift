import Foundation

class UniversityNetworkService : UniversityNetworkServiceProtocol  {
    // Ссылочка для университетов
    private let baseURL = "http://universities.hipolabs.com/search"
    private let cacheFileURL: URL
    // На страничке по 10 элементов будет
    private let itemsPerPage = 20
    
    init() {
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheFileURL = cachesDirectory.appendingPathComponent("universities_cache.json")
    }
    
    // К сожалению, Api не поддерживает пагинацию, поэтому сделала через offset, теперь можно переключаться между страничками
    func getUniversities(page: Int, completion: @escaping (Result<[UniversityEntry], Error>) -> Void) {
        let offset = page * itemsPerPage
        
        if let cachedData = try? Data(contentsOf: cacheFileURL),
           let cachedUniversities = try? JSONDecoder().decode([UniversityEntry].self, from: cachedData) {
            completion(.success(cachedUniversities))
            return
        }
        
        var components = URLComponents(string: baseURL)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: String(itemsPerPage)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        
        components?.queryItems = queryItems
        
        //Чтобы пользователь не подал имя, с вопросом, например
        guard let url = components?.url else {
            completion(.failure(UniversityErrors.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UniversityErrors.emptyData))
                return
            }
            
            do {
                let universities = try JSONDecoder().decode([UniversityEntry].self, from: data)
                try data.write(to: self.cacheFileURL, options: .atomic)
                
                completion(.success(universities))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Инвалидации кэша
    func invalidateCache() {
        try? FileManager.default.removeItem(at: cacheFileURL)
    }
}
