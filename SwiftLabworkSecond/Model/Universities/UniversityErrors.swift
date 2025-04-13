import Foundation

enum UniversityErrors: Error, LocalizedError {
    case invalidURL
    case emptyData
    case decodingError
    case cacheWriteError
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Не удалось сформировать корректный URL."
        case .decodingError:
            return "Ошибка при попытке прочитать данные с сервера."
        case .cacheWriteError:
            return "Не удалось сохранить данные в кэш."
        case .custom(let message):
            return message
        case .emptyData:
            return "Данных нет"
        }
    }
}

