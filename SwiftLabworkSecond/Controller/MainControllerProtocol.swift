
//Контроллер для главной странички, на которой будут размещена, осноавная таблица вакансий, которую полдьзователь сможет редактировать
protocol MainControllerProtocol {
    // Инициализация при загрузке экрана
    func load()
    // Добавление новой записи
    func addEntry()
    // Выбор записи в таблице
    func select(at index: Int)
    // Обновление записи
    func updateEntry(_ entry: JobSearchEntry, at index: Int)
    // Удаление записи
    func deleteEntry(at index: Int)
    // Сохранение изменений
    func saveChanges()
    // Получение данных
    func getEntries()
}
