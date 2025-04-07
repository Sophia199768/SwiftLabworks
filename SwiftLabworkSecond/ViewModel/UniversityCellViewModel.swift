import Foundation

// Ячейка университета
struct UniversityCellViewModel: ViewModel {
    typealias View = UniversityCellView
    
    let name: String
    let country: String
    let imageURL: String?
    
    init(university: UniversityEntry) {
        self.name = university.name
        self.country = university.country
        // Моя картинка, для университетов
        self.imageURL = "https://t4.ftcdn.net/jpg/02/04/90/57/360_F_204905727_Ip6maQp8OTrwW8nMmhNZXp0cUuYxaeMj.jpg"
    }
}
