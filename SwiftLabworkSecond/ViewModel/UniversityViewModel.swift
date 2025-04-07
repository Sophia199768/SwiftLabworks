import Foundation

class UniversityViewModel {
    let networkService: UniversityNetworkService
    private var universities: [UniversityEntry] = []
    private var currentPage = 0
    private var isLoading = false
    
    var onUniversitiesUpdated: (() -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    
    var cellViewModels: [UniversityCellViewModel] {
        return universities.map { UniversityCellViewModel(university: $0) }
    }
    
    init(networkService: UniversityNetworkService = UniversityNetworkService()) {
        self.networkService = networkService
    }
    
    func loadUniversities() {
        guard !isLoading else { return }
        isLoading = true
        onLoadingStateChanged?(true)
        
        networkService.getUniversities(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                self.onLoadingStateChanged?(false)
                
                switch result {
                case .success(let newUniversities):
                    self.universities.append(contentsOf: newUniversities)
                    self.currentPage += 1
                    self.onUniversitiesUpdated?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func resetAndLoadUniversities() {
        universities.removeAll()
        currentPage = 0
        networkService.invalidateCache()
        loadUniversities()
    }
    
    func university(at index: Int) -> UniversityEntry? {
        return universities.indices.contains(index) ? universities[index] : nil
    }
    
    var numberOfUniversities: Int {
        return universities.count
    }

    var universitiesList: [UniversityEntry] {
        return universities
    }
}
