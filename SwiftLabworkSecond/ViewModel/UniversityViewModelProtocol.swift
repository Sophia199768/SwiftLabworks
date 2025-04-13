import Foundation

protocol UniversityViewModelProtocol {
    var cellViewModels: [UniversityCellViewModel] { get }
    var numberOfUniversities: Int { get }
    var universitiesList: [UniversityEntry] { get }

    var onUniversitiesUpdated: (() -> Void)? { get set }
    var onLoadingStateChanged: ((Bool) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }

    func loadUniversities()
    func resetAndLoadUniversities()
    func university(at index: Int) -> UniversityEntry?
}

