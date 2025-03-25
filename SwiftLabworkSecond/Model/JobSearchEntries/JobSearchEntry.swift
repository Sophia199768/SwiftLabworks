
//Сущность вакансий
struct JobSearchEntry {
    var id: Int128
    //На какую позицию ищут, например, junior
    var position: String
    // Имя компании
    var companyName: String
    // Какие скиллы нужны
    // например, значение docker-а
    var skills: String
    // Статус для пользователя
    // например, в процессе прохождения интервью
    var status: String
    // Вывод
    // например, оффер
    var conclusion: String
    var user: User
}
