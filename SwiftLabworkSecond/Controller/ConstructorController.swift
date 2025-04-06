

//Контроллер для странички конструктора, страничка нужна, чтобы пользователь мог сам себе создавать задачки
//Пример задачи: Загрузить резюме, high priority
protocol ConstructorControllerProtocol {
    // Инициализация при загрузке экрана
    func viewLoad()
    // Добавление новой задачи
    func tapAddItem()
    // Переключение в режим редактирования
    func tapEditButton()
    // Выбор элемента в таблице
    func selectItem(at index: Int)
    // Обновление статуса
    func updateItem(_ item: AppTask, at index: Int)
    // Удаление задачи
    func deleteItem(at index: Int)
    // Сохранение изменений
    func saveChanges()
    // Получение данных
    func getTasks()
}
