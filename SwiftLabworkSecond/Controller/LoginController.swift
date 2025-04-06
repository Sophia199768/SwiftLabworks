
// Контроллер для входа
protocol LoginControllerProtocol {
    // Инициализация при загрузке экрана
    func viewDidLoad()
    // Нажатие на кнопку входа
    func login(username: String, password: String)
    // Выход
    func logOunt()
    // Изменение текста в поле логина
    func changeLogin(_ text: String)
    // Изменение текста в поле пароля
    func changePassword(_ text: String)
    // Валидация введенных данных
    func validateInput(username: String, password: String)

}
