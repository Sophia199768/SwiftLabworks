import Foundation

// Модель данных с сервера
// Использую Codable: "Для парсинга моделек предпочтительнее использовать Codable"
struct UniversityResponse: Decodable {
    let universities: [UniversityEntry]
}


// Сущность университет, помогает пользователю определиться в какой вуз надо пойти, чтобы получить работу мечты
struct UniversityEntry: Decodable {
    // Название университета
    let name: String
    // Номер страны, например, для России RU
    let alphaTwoCode: String
    // В какой стране данный университет
    let country: String
    // Ссылочки, чтобы узнать побольше
    let webPages: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case alphaTwoCode = "alpha_two_code"
        case country
        case webPages = "web_pages"
    }
}
