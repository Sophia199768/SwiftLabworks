import CoreData

// Страничка с основной информацией о пользователе
struct View {
    var id: Int128
    // Сколько уже ищет работу
    var timePeriod: Int
    // Когда начал
    var startData: Data
    // Прогресс
    // Например, сходил на интервью
    var progress: String
    var user: User
}
