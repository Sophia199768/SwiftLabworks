
//Контроллер для странички view, с основной информацией, о пользоавателе
protocol ViewControllerProtocol {
    // Инициализация при загрузке экрана
    func load()
    // Добавление новой сущности View
    func addView()
    // Обновление сущности
    func updateView(_ view: View, at index: Int)
    // Сохранение изменений
    func saveChanges()
    // Получение данных
    func getViews()
}
